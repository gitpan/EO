use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'EO',
      module_version  => '0.90',
      license         => 'perl',
      create_makefile_pl => 'traditional',
      requires        => {
			  Error => '0.15',
			  'Path::Class' => 0.01,
			  'Data::UUID' => '0.01',
			  'Clone' => '0.01',
			  'Data::Structure::Util' => '0.06',
			  'Attribute::Handlers'   => '0.01',
			 },
      build_requires => {
	  Test::More => 0,
      },
    )->create_build_script;
