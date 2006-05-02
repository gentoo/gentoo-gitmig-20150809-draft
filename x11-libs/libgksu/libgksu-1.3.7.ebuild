# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libgksu/libgksu-1.3.7.ebuild,v 1.2 2006/05/02 02:14:38 weeve Exp $

inherit gnome2

MY_PN="${PN}1.2"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}


DESCRIPTION="A library for integration of su into applications"
HOMEPAGE="http://www.nongnu.org/gksu/"
SRC_URI="http://people.debian.org/~kov/gksu/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="${IUSE} nls"

DEPEND=">=dev-util/gtk-doc-1.2-r1
	nls? ( >=sys-devel/gettext-0.14.1 )
	>=x11-libs/gtk+-2"

RDEPEND="${DEPEND}
	app-admin/sudo"

USEDESTDIR="1"
G2CONF="$(use_enable nls)"
