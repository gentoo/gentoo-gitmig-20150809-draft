# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnokii/gnokii-0.6.22-r2.ebuild,v 1.6 2008/05/21 15:52:49 dev-zero Exp $

WANT_AUTOMAKE="none"

inherit eutils linux-info autotools

DESCRIPTION="user space driver and tools for use with mobile phones"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 ~sparc x86"
IUSE="nls bluetooth ical irda sms postgres mysql usb X debug"

RESTRICT="test" #test fails; maybe it will work in the future, but till then...

RDEPEND="X? ( >=x11-libs/gtk+-2.8.19 )
	bluetooth? ( >=net-wireless/bluez-libs-2.25 )
	sms? ( >=dev-libs/glib-2.10.3
	       postgres? ( >=virtual/postgresql-server-8.0 )
	       mysql? ( >=virtual/mysql-4.1 )
	     )
	ical? ( >=dev-libs/libical-0.26.6 )
	usb? ( >=dev-libs/libusb-0.1.11 )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( >=sys-devel/gettext-0.14.5 )"

CONFIG_CHECK="UNIX98_PTYS"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs de et fi fr it nl pl pt sk sl sv zh_CN"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-locale.patch
	epatch "${FILESDIR}"/${P}-xmandir.patch

	if use sms ; then
		local MY_SMSD_DB_OBJS="file.lo"
		local MY_SMSD_DB_LIBS="libfile.la"
		if use postgres; then
			MY_SMSD_DB_OBJS="${MY_SMSD_DB_OBJS} pq.lo"
			MY_SMSD_DB_LIBS="${MY_SMSD_DB_LIBS} libpq.la"
		fi
		if use mysql; then
			MY_SMSD_DB_OBJS="${MY_SMSD_DB_OBJS} mysql.lo"
			MY_SMSD_DB_LIBS="${MY_SMSD_DB_LIBS} libmysql.la"
		fi

		sed -i \
			-e "s/^\(DB_OBJS[\t ]*=\).*$/\1 ${MY_SMSD_DB_OBJS}/" \
			-e "s/^\(DB_LIBS[\t ]*=\).*$/\1 ${MY_SMSD_DB_LIBS}/" \
			-e 's/\(^.*LIBTOOL.*--mode=finish.*$\)/#\1/' \
			smsd/Makefile

		#Change default database module
		local MY_DEFAULT_DB_MODULE="file"
		if use postgres ; then
			MY_DEFAULT_DB_MODULE="pq"
		elif use mysql ; then
			MY_DEFAULT_DB_MODULE="mysql"
		fi
		sed -i -e "s/\(smsdConfig[.]dbMod[\t ]*=.*\"\).*\(\"\)/\1${MY_DEFAULT_DB_MODULE}\2/" smsd/smsd.c
	fi

	# sys-devel/gettext is needed for creating .mo files
	local lang MY_LANGUAGES=""
	for lang in ${MY_AVAILABLE_LINGUAS} ; do
		if use linguas_${lang} ; then
			MY_LANGUAGES="${MY_LANGUAGES} ${lang}"
		fi
	done
	sed -i -e "s:^ALL_LINGUAS=.*$:ALL_LINGUAS=\"${MY_LANGUAGES}\":" configure.in
	eautoconf
}

src_compile() {
	config_xdebug="--disable-xdebug"
	use X && use debug && config_xdebug="--enable-xdebug"

	econf \
		$(use_enable nls) \
		$(use_enable ical libical) \
		$(use_enable usb libusb) \
		$(use_enable irda) \
		$(use_enable bluetooth) \
		$(use_with X x) \
		$(use_enable debug) \
		${config_xdebug} \
		$(use_enable debug rlpdebug) \
	    --enable-security \
		--disable-unix98test \
		|| die "configure failed"

	emake -j1 || die "make failed"

	if use sms;	then
		pushd "${S}/smsd"
		emake || die "smsd make install failed"
		popd
	fi
}

src_install() {
	einstall install-includes || die "make install failed"

	if use X; then
		insinto /usr/share/pixmaps
		newins Docs/sample/logo/gnokii.xpm xgnokii.xpm
	fi

	insinto /etc
	doins Docs/sample/gnokiirc
	sed -i -e 's:/usr/local:/usr:' "${D}/etc/gnokiirc"

	doman Docs/man/*

	dodir "/usr/share/doc/${PF}"
	cp -r Docs/sample "${D}/usr/share/doc/${PF}/sample"
	cp -r Docs/protocol "${D}/usr/share/doc/${PF}/protocol"
	rm -rf Docs/man Docs/sample Docs/protocol
	dodoc Docs/* ChangeLog TODO MAINTAINERS

	# only one file needs suid root to make a pseudo device
	fperms 4755 /usr/sbin/mgnokiidev

	if use sms;	then
		pushd "${S}/smsd"
		einstall || die "smsd make install failed"
		insinto /usr/share/doc/${PF}/smsd
		use mysql && doins sms.tables.mysql.sql README.MySQL
		use postgres && doins sms.tables.pq.sql
		doins README ChangeLog README.Tru64 action
		popd
	fi
}

pkg_postinst() {
	elog "Make sure the user that runs gnokii has read/write access to the device"
	elog "which your phone is connected to."
	elog "The simple way of doing that is to add your user to the uucp group."
}
