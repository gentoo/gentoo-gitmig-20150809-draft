# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cipe/cipe-1.5.4.ebuild,v 1.5 2004/07/15 02:42:27 agriffis Exp $

inherit eutils

CIPE_TEXINFO="${PN}-1.5.1.texinfo"

DESCRIPTION="Cryptographic IP tunneling daemon/module"
HOMEPAGE="http://sites.inka.de/bigred/devel/cipe.html"
SRC_URI="http://sites.inka.de/bigred/sw/${P}.tar.gz
	http://sites.inka.de/bigred/sw/${CIPE_TEXINFO}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="ssl"

RDEPEND="virtual/libc
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="${RDEPEND}
	virtual/linux-sources"

src_unpack() {
	unpack ${A}

	cp ${DISTDIR}/${CIPE_TEXINFO} ${S}/${PN}.texinfo

	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	local myconf=""

	use ssl \
		&& myconf="${myconf} --enable-pkcipe" \
		|| myconf="${myconf} --disable-pkcipe"

	# A custom use flag for bug compatability mode
	# Do we need this?
	#use cipebc && myconf="${myconf} --enable-bug-compatible"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc/cipe
	insopts -m755
	doins samples/ip-{up,down}
	insopts -m600
	doins samples/options

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d-ciped ciped


	dodoc README* CHANGES COPYING tcpdump.patch
	dodoc samples/{ip-{up,down},options}
}

pkg_postinst() {
	if [ -f /usr/bin/rsa-keygen ] && [ ! -f /etc/cipe/identity.priv ]
	then
		ebegin "Generating new identity (host) key"
		emsg="`rsa-keygen /etc/cipe/identity 2>&1`"
		eend $? $emsg
	fi

	update-modules
	depmod -a

	echo  " "
	einfo "For info on configuring cipe, do 'info cipe'"
}
