require 'pathname'

ROOT = Pathname.new(__FILE__).join('..', '..')
$LOAD_PATH.unshift(ROOT)
