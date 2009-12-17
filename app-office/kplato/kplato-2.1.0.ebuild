# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kplato/kplato-2.1.0.ebuild,v 1.2 2009/12/17 10:36:21 ssuominen Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KPlato is a project management application."

KEYWORDS="amd64 ~x86"
IUSE=""

KMEXTRACTONLY="libs/"
KMEXTRA="
	filters/${KMMODULE}/
	kdgantt/
"
KMLOADLIBS="koffice-libs"
