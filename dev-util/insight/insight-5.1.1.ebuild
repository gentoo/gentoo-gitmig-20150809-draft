# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-5.1.1.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sources.redhat.com/insight/index.html"

SRC_URI="ftp://sources.redhat.com/pub/gdb/releases/${P}.tar.bz2"
S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
        sys-libs/ncurses
        nls? ( sys-devel/gettext )"

INSIGHTDIR="/opt/insight"

src_compile() {
    local myconf
    if [ -z "`use nls`" ]; then
	myconf="--disable-nls"
    fi
    ./configure \
	--host="${CHOST}" \
	--prefix="${INSIGHTDIR}" \
	--without-included-regex \
	--without-included-gettext \
	${myconf} || die
    emake || die
}

src_install () {
    make prefix="${D}${INSIGHTDIR}" install || die
    dosym /opt/insight/bin/gdb /opt/insight/bin/insight
    insinto /etc/env.d
    doins "${FILESDIR}/99insight"
}
