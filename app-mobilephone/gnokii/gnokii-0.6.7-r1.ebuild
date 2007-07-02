# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnokii/gnokii-0.6.7-r1.ebuild,v 1.13 2007/07/02 17:32:00 armin76 Exp $

inherit eutils flag-o-matic linux-info

DESCRIPTION="user space driver and tools for use with mobile phones"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="nls X bluetooth irda sms postgres mysql"

RDEPEND="X? ( =x11-libs/gtk+-1.2* )
	bluetooth? ( net-wireless/bluez-libs )
	sms? ( >=dev-libs/glib-2
	       postgres? ( dev-db/postgresql )
	       mysql? ( virtual/mysql )
	     )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	sys-devel/autoconf"

CONFIG_CHECK="UNIX98_PTYS"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-smsd-glib2.patch
}

src_compile() {
	append-ldflags "-Wl,-z,now" #avoid QA notices

	autoconf && econf \
		$(use_enable nls) \
		$(use_with X x) \
		--disable-debug \
		--disable-xdebug \
		--disable-rlpdebug \
	    --enable-security \
		--disable-unix98test \
		|| die "configure failed"

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
	sed -i -e 's:/usr/local:/usr:' ${D}/etc/gnokiirc

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
	elog "gnokii does not need it's own group anymore."
	elog "Make sure the user that runs gnokii has read/write access to the device"
	elog "which your phone is connected to. eg. chown <user> /dev/ttyS0"
}
