## v2.0.0 (2021-09-23)

- Bump lower-bound on Cstruct to 6.0.0 (@MisterDA, @djs55, @dinosaure, #74)
- Update to Dune 2.9 and generate opam files (@MisterDA, @djs55, @dinosaure, #74)
- Support only OCaml versions 4.08 and higher. (@MisterDA, @dinosaure, #77)
- Don't print any logging to stdout or stderr (@MisterDA, @djs55, @dinosaure, #74)
- Remove `Tar.Make.Header`, `Tar_cstruct.Header`, `Tar_unix.Header`, and
  `Tar_lwt_unix.Header` to keep only Tar.Header and use it everywhere.
  - `Tar.Make.Header.get_next_header` becomes `Tar.Make.get_next_header`;
  - `Tar_cstruct.Header.get_next_header` becomes `Tar_cstruct.get_next_header`;
  - `Tar_lwt_unix.Header.get_next_header` becomes `Tar_lwt_unix.get_next_header`;
  - `Tar_lwt_unix.Header.of_file` becomes `Tar_lwt_unix.header_of_file`;
  - `Tar_unix.Header.get_next_header` becomes `Tar_unix.get_next_header`;
  - `Tar_unix.Header.of_file` becomes `Tar_unix.header_of_file`;
  - All the `Tar_*.Header.t` values have to be changed to `Tar.Header.t`.
  (@MisterDA, @dinosaure, #77)
- Fix parsing of pax Extended Header File Times with sub-second
  granularity. (@MisterDA, @dinosaure, #77)
- Add `Tar_unix.transform` and `Tar_lwt_unix.transform` to help
  transforming headers of a streamed tar archive between two file
  descriptors. (@MisterDA, @dinosaure, #77)
- Remove `{build}` tag on the `dune` dependency (@CraigFe, @hannesm, #72)
- Adapt `ocaml-tar` to newer MirageOS interfaces (@hannesm, @dinosaure, #73)
- Update gnu.org link (@reynir, @dinosaure, #79)
- `file_mode` defaults to `0o400` (@reynir, @MisterDA, @dinosaure, #78)

## v1.1.0 (2019-04-08)

- Do not depend on mirage-types, use mirage-kv instead (@hannesm)
- Support mirage-kv 2.0.0 (@hannesm)
- Do not suppress "unused value" warning (@emillon)
- Represent link indicator as a char. This transforms comments into actual code
  (@emillon)

## v1.0.1 (2019-02-04)
- fix tar-unix build with modern cstruct.lwt (@avsm)

## v1.0.0 (2019-02-03)
- port build to dune from builder (@avsm)
- upgrade opam metadata to 2.0 (@avsm)
- remove topkg in favour of dune-release (@avsm)
- use modern `ppx_cstruct` instead of `cstruct.ppx` (#65 @avsm @djs55)
- test with OCaml 4.07 as well (@avsm)

## v0.9.0 (2017-11-25)

- preliminary support for Cstruct.t-backed tar processing (#54 by @hcarty)
- fix build with OCaml 4.06.0 (and `-safe-string`)

## v0.8.0 (2017-05-09)

- split into 3 packages: `tar`, `tar-unix`, `tar-mirage`
- use jbuilder for building
- add support for reading @LongLink headers
- mark deprecated functions with @@ocaml.deprecated
- fix some warnings

## v0.7.1 (2017-02-03)

- convert build system to topkg (#43, @hannesm)

## v0.7.0 (2017-01-19)

- Build against MirageOS version 3, and drop support for earlier versions.
- Support only OCaml versions 4.03 and higher.

## v0.6.1 (2016-09-30)

- fix a bug in the key=value interface when the archive isn't a multiple
  of 4KiB in size

## v0.6.0 (2016-09-19)

- support for pax headers
- removed Tar.Archive.fold: please use HeaderReader instead

## v0.5.1 (2016-08-30)

- handle EINTR and short writes properly (@ivg)
- avoid a warning catching `Failure` exceptions from `int_of_string`

## v0.5.0 (2016-04-24)

- now requires cstruct >= 1.9.0 and OCaml 4.02+

## v0.4.2 (2016-04-22)

- test: only run tests if mirage-block-unix is present
- improve the opam file
- travis: simplify the configuration

## v0.4.1 (2015-07-21)

- fix Tar_mirage when using block devices with < 4096 byte
  sectors

## v0.4.0 (2015-07-19)

- add tar.mirage in ocamlfind, containing Tar_mirage which
  exposes a BLOCK device as a KV_RO

## v0.3.0 (2015-04-06)

- add Tar.Make functor which allows easier integration with
  camlzip
- always initialise tar header unused bytes to 0 (previously
  would use uninitialised data)
- modernise Travis CI scripts to use OPAM 1.2 workflow.

## v0.2.1 (2013-11-15)

- Re-add some old deprecated functions

## v0.2.0 (2013-10-13)

- Add 'Tar.Archive.fold' for folding over entries in an archive

## v0.1.1 (2013-10-03)

- Rename ocamlfind package from 'ocaml-tar' to simply 'tar'

## v0.1.0 (2013-10-03)

- Initial release
