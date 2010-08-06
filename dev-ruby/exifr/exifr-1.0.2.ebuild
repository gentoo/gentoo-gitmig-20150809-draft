# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/exifr/exifr-1.0.2.ebuild,v 1.1 2010/08/06 05:59:09 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_DOCDIR="doc/api"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A library to read EXIF info from JPEG and TIFF images."
HOMEPAGE="http://exifr.rubyforge.org/"

# License is not specified in source distribution but is in the GitHub
# repository.
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"
