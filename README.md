## Tools for benchmarking Jekyll

This purpose of this repo is to hold tools that can be used to benchmark
Jekyll. Initially, it starts with a single script and a couple of
support files to generate test sites.

Currently planned features include the following:
 - More scripts or a framework to build more complex sites to use for
   different types of benchmarks.
 - A plugin that uses Jekyll's hooks to instrument how long certain
   operations take.
 - A set of tools that can be used to track Jekyll's performance over
   time, integrate with CI, and  provide status checks that integrate
   with GitHub in order to notify Jekyll's developers of performance
   regressions.

## How to use the `generate_site.sh` script

You can run the script straight from the cloned repository using

    bash generate_site.sh X .

...where `X` is the number of posts you want to generate.

If you want to test the various Jekyll plugins and how they affect the 
build, you'll need to do the following:
 - Run a couple of tests on the clean installation to have some basic
   values to work with (increase `X` incrementally to do this).
 - Create a `_plugins` folder and put the `.rb` file of the plugin there.
 - Run the tests using the same `X` values as you've used in the
   bare installation.
 - Compare the results of those two sets of tests.

## License

MIT. See the [LICENSE](LICENSE) file for more details
