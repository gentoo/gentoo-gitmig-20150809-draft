# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythweather/mythweather-0.22_p22991.ebuild,v 1.1 2010/01/04 05:58:18 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Weather forecast module for MythTV."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/DateManip
	dev-perl/ImageSize
	dev-perl/SOAP-Lite
	dev-perl/XML-Simple
	dev-perl/XML-Parser
	dev-perl/XML-SAX"

src_install() {
	mythtv-plugins_src_install

	# correct permissions so MythWeather is actually usable
	fperms 755 /usr/share/mythtv/mythweather/scripts/*/*.pl
}
