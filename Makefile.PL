use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'YAML::ConfigFile',
    'VERSION_FROM'	=> 'lib/YAML/ConfigFile.pm', # finds $VERSION
    'PREREQ_PM'		=> {
                            'YAML'         => 0.16,
                            },
);
