# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gob/gob-2.0.6.ebuild,v 1.1 2003/05/22 13:18:19 foser Exp $

inherit gnome2

MY_P=${PN}2-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="preprocessor for making GTK+ objects with inline C code"
SRC_URI="http://ftp.5z.com/pub/gob/${MY_P}.tar.gz"
HOMEPAGE="http://www.5z.com/jirka/gob.html"
IUSE=""

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

RDEPEND=">=dev-libs/glib-2.0*"

DEPEND="${RDEPEND}
	sys-devel/flex"

DOCS="AUTHORS COPYING.generated-code ChangeLog NEWS README TODO"

USE_DESTDIR="1"

