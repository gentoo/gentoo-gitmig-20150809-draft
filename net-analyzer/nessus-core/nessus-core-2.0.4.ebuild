# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-core/nessus-core-2.0.4.ebuild,v 1.1 2003/04/23 08:51:07 aliz Exp $

IUSE="tcpd X gtk gtk2"
S=${WORKDIR}/${PN}
DESCRIPTION="A remote security scanner for Linux (nessus-core)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"
DEPEND="=net-analyzer/libnasl-${PV}
	tcpd? ( sys-apps/tcp-wrappers )
	X? ( x11-base/xfree )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( =x11-libs/gtk+-2* )"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc ~alpha"

src_compile() {
	local myconf
	use X && myconf="--with-x" || myconf="--without-x"
	if [ `use gtk` ]; then
		myconf="${myconf} --enable-gtk"
	elif [ `use gtk2`]; then
		myconf="${myconf} --enable-gtk"
	else
		myconf="${myconf} --disable-gtk"
	fi
	use tcpd && myconf="${myconf} --enable-tcpwrappers" \
		|| myconf="${myconf} --disable-tcpwrappers"
	if [ ! -z $DEBUGBUILD ]; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi
	econf ${myconf} || die "configure failed"
	emake || die "emake failed"

}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		mandir=${D}/usr/share/man \
		install || die "Install failed nessus-core"
	cd ${S}
	dodoc README* UPGRADE_README CHANGES
	dodoc doc/*.txt doc/ntp/*
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/nessusd-r6 nessusd
	keepdir /var/lib/nessus/logs
	keepdir /var/lib/nessus/users
}
