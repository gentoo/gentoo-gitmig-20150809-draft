# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnokii/gnokii-0.6.4.ebuild,v 1.1 2004/11/17 23:07:36 mrness Exp $

inherit eutils flag-o-matic

DESCRIPTION="a client that plugs into your handphone"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~alpha ~ppc64"
IUSE="nls X bluetooth irda sms postgres mysql"

RDEPEND="X? ( =x11-libs/gtk+-1.2* )
	bluetooth? ( net-wireless/bluez-libs )
	irda? ( virtual/os-headers )
	sms? ( postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql ) )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S} && \
		sed -i -e 's:/usr/local/:/usr/:g' Docs/sample/gnokiirc && \
		epatch ${FILESDIR}/${P}-nounix98pty.patch || \
			die "something has changed in this package"
}

src_compile() {
	append-ldflags "-Wl,-z,now" #avoid QA notices

	econf \
		`use_enable nls` \
		`use_with X x` \
	    --enable-security || die "configure failed"

	emake -j1 || die "make failed"

	if use sms
	then
		cd ${S}/smsd

		if use postgres; then
			emake libpq.la || die "smsd make failed"
		elif use mysql; then
			emake libmysql.la || die "smsd make failed"
		else
			emake libfile.la || die "smsd make failed"
		fi
	fi
}

src_install() {
	einstall || die "make install failed"

	insinto /etc
	doins Docs/sample/gnokiirc

	doman Docs/man/*
	dodir /usr/share/doc/${PF}
	cp -r Docs/sample ${D}/usr/share/doc/${PF}/sample
	cp -r Docs/protocol ${D}/usr/share/doc/${PF}/protocol
	rm -rf Docs/man Docs/sample Docs/protocol
	dodoc Docs/*

	# only one file needs suid root to make a psuedo device
	fperms 4755 /usr/sbin/mgnokiidev

	if use sms;	then
		cd ${S}/smsd

		einstall || die "smsd make install failed"
	fi

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}

pkg_postinst() {
	einfo "gnokii does not need it's own group anymore."
	einfo "Make sure the user that runs gnokii has read/write access to the device"
	einfo "which your phone is connected to. eg. chown <user> /dev/ttyS0"
}
