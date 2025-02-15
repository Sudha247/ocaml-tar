(*
 * Copyright (C) 2006-2009 Citrix Systems Inc.
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

(** Lwt_unix I/O for tar-formatted data *)

val really_read: Lwt_unix.file_descr -> Cstruct.t -> unit Lwt.t
(** [really_read fd buf] fills [buf] with data from [fd] or fails
    with {!Stdlib.End_of_file}. *)

val really_write: Lwt_unix.file_descr -> Cstruct.t -> unit Lwt.t
(** [really_write fd buf] writes the full contents of [buf] to
    [fd] or fails with {!Stdlib.End_of_file}. *)

(** Returns the next header block or None if two consecutive
    zero-filled blocks are discovered. Assumes stream is positioned at the
    possible start of a header block.
    @raise Stdlib.End_of_file if the stream unexpectedly fails. *)
val get_next_header : ?level:Tar.Header.compatibility -> Lwt_unix.file_descr -> Tar.Header.t option Lwt.t

(** Return the header needed for a particular file on disk. *)
val header_of_file : ?level:Tar.Header.compatibility -> string -> Tar.Header.t Lwt.t

module Archive : sig
  (** Utility functions for operating over whole tar archives *)

  (** Read the next header, apply the function 'f' to the fd and the header. The function
      should leave the fd positioned immediately after the datablock. Finally the function
      skips past the zero padding to the next header. *)
  val with_next_file : Lwt_unix.file_descr -> (Lwt_unix.file_descr -> Tar.Header.t -> 'a Lwt.t) -> 'a option Lwt.t

  (** List the contents of a tar to stdout. *)
  val list : ?level:Tar.Header.compatibility -> Lwt_unix.file_descr -> Tar.Header.t list Lwt.t

  (** [extract dest] extract the contents of a tar.
     Apply [dest] on each source filename to change the destination
     filename. It only supports extracting regular files from the
     top-level of the archive. *)
  val extract : (string -> string) -> Lwt_unix.file_descr -> unit Lwt.t

  (** [transform f in_fd out_fd] applies [f] to the header of each
     file in the tar inputted in [in_fd], and writes the resulting
     headers to [out_fd] preserving the content and structure of the
     archive. *)
  val transform : ?level:Tar.Header.compatibility -> (Tar.Header.t -> Tar.Header.t) -> Lwt_unix.file_descr -> Lwt_unix.file_descr -> unit Lwt.t

  (** Create a tar on file descriptor fd from a list of filenames. It
     only supports regular files. *)
  val create : string list -> Lwt_unix.file_descr -> unit Lwt.t
end
