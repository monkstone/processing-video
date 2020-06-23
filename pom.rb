# frozen_string_literal: true

project 'processing-video', 'https://github.com/monkstone/propane' do
  model_version '4.0.0'
  id 'org.processing:video:4.0.0'
  packaging 'jar'

  description 'Processing-video (somewhat hacked), with additional java code for a jruby version of processing.'

  {
    'monkstone' => 'Martin Prout',
    'codeanticode' => 'Andres Colubri'
  }.each do |key, value|
    developer key do
      name value
      roles 'developer'
    end
  end

  issue_management 'https://github.com/ruby-processing/propane/issues', 'Github'

  source_control(url: 'https://github.com/ruby-processing/propane',
                 connection: 'scm:git:git://github.com/ruby-processing/propane.git',
                 developer_connection: 'scm:git:git@github.com/ruby-processing/propane.git')

  properties('video.basedir' => '${project.basedir}',
             'processing.api' => 'http://processing.github.io/processing-javadocs/core/',
             'source.directory' => '${video.basedir}/src',
             'outputDirectory' => '${video.basedir}/library',
             'polyglot.dump.pom' => 'pom.xml'
             )


  jar 'org.processing:core:3.3.7' # only for compiling
  jar 'org.freedesktop.gstreamer:gst1-java-core:1.2.0'
  jar 'net.java.dev.jna:jna:5.5.0'

  overrides do
    plugin :resources, '3.1.0'
    plugin(:dependency, '3.1.2',
      'excludeGroupIds' => 'org.processing',
      'stripVersion' => true) do
      execute_goals 'copy-dependencies'
    end
    plugin(:compiler, '3.8.1',
           'release' => '11')
    plugin(:javadoc, '2.10.4',
           'detectOfflineLinks' => 'false',
           'links' => ['${processing.api}',
                       '${jruby.api}'])
    plugin(:jar, '3.2.0',
      'archive' => {
        'manifestEntries' => {
          'Automatic-Module-Name' =>  'org.processing.video'
        }
           })
    plugin :jdeps, '3.1.2' do
      execute_goals 'jdkinternals', 'test-jdkinternals'
    end
  end

  build do
    resource do
      directory '${source.directory}/main/java'
      excludes '**/**/*.java'
    end
  end
end
