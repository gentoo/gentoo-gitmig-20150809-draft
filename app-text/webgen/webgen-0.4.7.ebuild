# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/webgen/webgen-0.4.7.ebuild,v 1.1 2008/01/18 11:53:26 agorf Exp $

inherit ruby gems

DESCRIPTION="A template-based static website generator."
HOMEPAGE="http://webgen.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="builder exif highlight markdown thumbnail"

DEPEND=">=dev-ruby/cmdparse-2.0.0
		>=dev-ruby/redcloth-2.0.10
		builder? ( >=dev-ruby/builder-2.0.0 )
		exif? ( >=dev-ruby/exifr-0.10 )
		highlight? ( >=dev-ruby/coderay-0.7.4.215 )
		markdown? ( || ( >=dev-ruby/bluecloth-1.0.0 dev-ruby/maruku ) )
		thumbnail? ( >=dev-ruby/rmagick-1.7.1 )"
RDEPEND="${DEPEND}"
