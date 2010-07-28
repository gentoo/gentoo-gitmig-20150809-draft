# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythweather/mythweather-0.23.1_p25396.ebuild,v 1.2 2010/07/28 21:11:59 cardoe Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="Weather forecast module for MythTV."
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/DateManip
	dev-perl/DateTime-Format-ISO8601
	dev-perl/ImageSize
	dev-perl/SOAP-Lite
	dev-perl/XML-Simple
	dev-perl/XML-Parser
	dev-perl/XML-SAX
	dev-perl/XML-XPath"

src_install() {
	mythtv-plugins_src_install

	# correct permissions so MythWeather is actually usable
	fperms 755 /usr/share/mythtv/mythweather/scripts/*/*.pl
}
