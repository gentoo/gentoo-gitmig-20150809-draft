# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/externaleditor/externaleditor-0.7.2.ebuild,v 1.1 2004/09/11 21:23:25 lanius Exp $

inherit zproduct

DESCRIPTION="The ExternalEditor is a Zope product and configurable helper application that allows you to drop into your favorite editor(s) directly from the ZMI to modify Zope objects."
HOMEPAGE="http://www.zope.org/Members/Caseman/ExternalEditor/"
SRC_URI="http://www.zope.org/Members/Caseman/ExternalEditor/${PV}/ExternalEditor-${PV}-src.tgz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
IUSE=""

ZPROD_LIST="ExternalEditor"
