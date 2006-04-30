# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnokii/gnokii-0.6.11-r1.ebuild,v 1.3 2006/04/30 20:59:28 mrness Exp $

inherit eutils flag-o-matic linux-info

DESCRIPTION="user space driver and tools for use with mobile phones"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls X bluetooth irda sms postgres mysql"

RESTRICT="maketest" #test fails; maybe it will work in the future, but till then...

RDEPEND="X? ( =x11-libs/gtk+-1.2* )
	bluetooth? ( net-wireless/bluez-libs )
	sms? ( >=dev-libs/glib-2
	       postgres? ( dev-db/postgresql )
	       mysql? ( dev-db/mysql )
	     )
	dev-libs/libical"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	sys-devel/autoconf"

CONFIG_CHECK="UNIX98_PTYS"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-vcal.patch"
}

src_compile() {
	append-ldflags $(bindnow-flags) #avoid QA notices

	autoconf && econf \
		$(use_enable nls) \
		$(use_with X x) \
		--disable-debug \
		--disable-xdebug \
		--disable-rlpdebug \
	    --enable-security \
		--disable-unix98test \
		|| die "configure failed"

	if use sms ; then
		cd "${S}/smsd"

		if use postgres; then
			emake libpq.la || die "smsd make failed"
		elif use mysql; then
			emake libmysql.la || die "smsd make failed"
		else
			emake libfile.la || die "smsd make failed"
		fi

		cd "${S}"
	fi

	emake -j1 || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	insinto /etc
	doins Docs/sample/gnokiirc
	sed -i -e 's:/usr/local:/usr:' "${D}/etc/gnokiirc"

	doman Docs/man/*
	dodir "/usr/share/doc/${PF}"
	cp -r Docs/sample "${D}/usr/share/doc/${PF}/sample"
	cp -r Docs/protocol "${D}/usr/share/doc/${PF}/protocol"
	rm -rf Docs/man Docs/sample Docs/protocol
	dodoc Docs/*

	# only one file needs suid root to make a psuedo device
	fperms 4755 /usr/sbin/mgnokiidev

	if use sms;	then
		cd "${S}/smsd"

		einstall || die "smsd make install failed"

		cd "${S}"
	fi

	if use X; then
		insinto /usr/share/applications
		doins xgnokii/xgnokii.desktop
	fi
}

pkg_postinst() {
	einfo "gnokii does not need it's own group anymore."
	einfo "Make sure the user that runs gnokii has read/write access to the device"
	einfo "which your phone is connected to. eg. chown <user> /dev/ttyS0"
}
