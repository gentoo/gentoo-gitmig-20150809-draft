# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-5.1.1.ebuild,v 1.6 2002/10/05 05:39:12 drobbins Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sources.redhat.com/insight/index.html"
SRC_URI="ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

INSIGHTDIR="/opt/insight"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	make prefix="${D}${INSIGHTDIR}" install || die
	dosym /opt/insight/bin/gdb /opt/insight/bin/insight
	insinto /etc/env.d
	doins "${FILESDIR}/99insight"
}
