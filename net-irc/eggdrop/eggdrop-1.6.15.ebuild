# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/eggdrop/eggdrop-1.6.15.ebuild,v 1.9 2004/01/03 17:48:15 zul Exp $

inherit fixheadtails

DESCRIPTION="An IRC bot extensible with C or Tcl."
HOMEPAGE="http://www.eggheads.org/"
SRC_URI="ftp://ftp.eggheads.org/pub/eggdrop/source/1.6/eggdrop${PV}.tar.gz"
KEYWORDS="x86 sparc mips ia64"

LICENSE="GPL-2"
SLOT="0"

IUSE="debug static ipv6"
DEPEND="dev-lang/tcl"

pre_pkg() {
	use ipv6 && \
		ewarn "Note: If eggdrop is built with ipv6 support, the dns.so module is"
		ewarn "not built."
}

src_unpack()  {

	unpack ${A}
	mv ${WORKDIR}/eggdrop${PV} ${WORKDIR}/${P}

	epatch ${FILESDIR}/eggdrop-1.6.15-config.patch
	epatch ${FILESDIR}/eggdrop-1.6.15-botchk.patch
	epatch ${FILESDIR}/eggdrop-1.6.15-configure-in.patch
	epatch ${FILESDIR}/eggdrop-1.6.15-potential-undef-tm-struct.patch

	cd ${WORKDIR}/${P}
	ht_fix_file configure aclocal.m4

	autoconf || die "autoconf failed?!"

}

src_compile() {
	local mytarg myconf

	# Sets eggdrop to use ipv6
	use ipv6 && myconf="${myconf} --enable-ipv6"
	./configure \
		--host=${CHOST} \
		--disable-cc-optimization \
		${myconf} || die "./configure failed"

	make config || die "module config failed"

	if use static; then
		make static || die "make static failed"
	fi

	if use debug; then
		make debug || die "make debug failed"
	fi
	make || die "make failed"

}

src_install() {

	local a
	make DEST=${D}/opt/eggdrop install

	for a in doc/*
	do
		[ -f $a ] && dodoc $a
	done

	for a in doc/html/*
	do
		[ -f $a ] && dohtml $a
	done

	dobin ${FILESDIR}/eggdrop-installer
	doman doc/man1/eggdrop.1
}

pkg_postinfo() {
	einfo "Please run /usr/bin/eggdrop-insaller to install your eggdrop bot."
}
