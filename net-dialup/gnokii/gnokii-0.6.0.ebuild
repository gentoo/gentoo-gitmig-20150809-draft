# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnokii/gnokii-0.6.0.ebuild,v 1.6 2004/10/19 13:53:52 vapier Exp $

inherit eutils

DESCRIPTION="a client that plugs into your handphone"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls X bluetooth irda"

RDEPEND="X? ( =x11-libs/gtk+-1.2* )
	bluetooth? ( net-wireless/bluez-libs )
	irda? (	virtual/os-headers )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-0.5.4-nounix98pty.patch
}

src_compile() {
	econf \
		`use_enable nls` \
		`use_with X x` \
	    --enable-security || die "configure failed"

	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc Docs/*
	cp -r Docs/sample ${D}/usr/share/doc/${PF}/sample
	cp -r Docs/protocol ${D}/usr/share/doc/${PF}/protocol

	doman Docs/man/*

	dodir /etc
	sed -e 's:/usr/local/sbin:/usr/sbin:' ${S}/Docs/sample/gnokiirc > ${D}/etc/gnokiirc

	# only one file needs suid root to make a psuedo device
	fperms 4755 /usr/sbin/mgnokiidev
}

pkg_postinst() {
	einfo "gnokii does not need it's own group anymore."
	einfo "Make sure the user that runs gnokii has read/write access to the device"
	einfo "which your phone is connected to. eg. chown <user> /dev/ttyS0"

	# clean up old gnokii group perms
	groupdel gnokii
}

pkg_postrm () {
	# leaving to clean up the old mess we used to leave behind
	# since we don't _really_ need suid gnokii, just the make sure
	# the use has the right perms
	groupdel gnokii
}
