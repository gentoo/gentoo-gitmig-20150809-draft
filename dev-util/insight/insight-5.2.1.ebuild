# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-5.2.1.ebuild,v 1.1 2002/09/01 19:39:23 agenkin Exp $

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sources.redhat.com/insight/index.html"
LICENSE="GPL-2 LGPL-2"
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
KEYWORDS="x86 sparc sparc64"
SRC_URI="ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"
S=${WORKDIR}/${P}

INSIGHTDIR="/opt/insight"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	./configure --prefix="${INSIGHTDIR}" \
		--mandir="${D}${INSIGHTDIR}/share/man"	\
		--infodir="${D}${INSIGHTDIR}/share/info"	\
		${myconf} || die
	emake || die
}

src_install () {
	make \
		prefix="${D}${INSIGHTDIR}" \
	 	mandir="${D}${INSIGHTDIR}/share/man" \
                infodir="${D}${INSIGHTDIR}/share/info" \
		install || die
	dosym /opt/insight/bin/gdb /opt/insight/bin/insight
	insinto /etc/env.d
	doins "${FILESDIR}/99insight"
}
