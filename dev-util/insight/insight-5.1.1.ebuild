# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Marc Soda <marc@aspre.net>
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-5.1.1.ebuild,v 1.1 2002/03/03 18:19:07 agenkin Exp $

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
