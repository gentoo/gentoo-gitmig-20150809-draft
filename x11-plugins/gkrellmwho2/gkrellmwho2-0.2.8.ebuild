# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmwho2/gkrellmwho2-0.2.8.ebuild,v 1.10 2007/07/11 20:39:22 mr_bones_ Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${P}.orig
DESCRIPTION="This plugin displays currently logged in users in the scrolling line. It also shows number of logins for each username and may show idle status"
SRC_URI="http://shisha.spb.ru/debian/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://shisha.spb.ru/projects/GkrellmWHO2"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
