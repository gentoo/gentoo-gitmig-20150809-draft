# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/nut/nut-2.0.0.ebuild,v 1.3 2007/06/29 17:06:39 armin76 Exp $

inherit eutils fixheadtails

DESCRIPTION="Network-UPS Tools"
HOMEPAGE="http://www.networkupstools.org/"
SRC_URI="mirror://nut/source/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="cgi snmp usb"

RDEPEND="cgi? ( media-libs/gd )
	snmp? ( net-analyzer/net-snmp )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.58"

pkg_setup() {
	enewgroup nut 84
	enewuser nut 84 -1 /var/state/nut nut
}

src_unpack() {
	unpack ${A} && cd "${S}"

	sed -e "s/install: install-dirs/install: install-dirs install-conf/" \
		-i Makefile.in || die "sed failed"

	ht_fix_file configure.in

	sed -e "s:GD_LIBS.*=.*-L/usr/X11R6/lib \(.*\) -lXpm -lX11:GD_LIBS=\"\1:" \
		-i configure.in || die "sed failed"

	ebegin "Recreating configure"
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	eend $?
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with cgi` `use_with cgi cgipath /usr/share/nut`"

	if [ -n "${NUT_DRIVERS}" ]; then
		myconf="${myconf} --with-drivers=${NUT_DRIVERS// /,}"
	fi

	econf \
		--with-user=nut \
		--with-group=nut \
		--with-drvpath=/lib/nut \
		--sysconfdir=/etc/nut \
		--with-logfacility=LOG_DAEMON \
		--with-statepath=/var/lib/nut \
		${myconf} || die "econf failed"

	emake || die "compile problem"

	if use snmp; then
		emake snmp || die "snmp compile problem"
	fi

	if use usb; then
		emake usb || die "snmp compile problem"
	fi

	if use cgi; then
		emake cgi || die "compile cgi problem"
	fi
}

src_install() {
	make DESTDIR="${D}" install install-lib || die "make install failed"

	dodir /sbin
	dosym /lib/nut/upsdrvctl /sbin/upsdrvctl

	for i in "${D}"/etc/nut/*.sample ; do
		mv "${i}" "${i/.sample/}"
	done

	if use snmp; then
		make DESTDIR="${D}" install-snmp || die "make install-snmp failed"
	fi

	if use usb; then
		make DESTDIR="${D}" install-usb || die "make install-usb failed"
	fi

	if use cgi; then
		make DESTDIR="${D}" install-cgi || die "make install-cgi failed"
		einfo "CGI monitoring scripts are installed in /usr/share/nut,"
		einfo "copy them to your web server's ScriptPath to activate."
	fi

	dodoc CHANGES COPYING CREDITS INSTALL MAINTAINERS NEWS README UPGRADING \
			docs/{FAQ,*.txt}

	newdoc lib/README README.lib

	docinto cables
	dodoc docs/cables/*


	newinitd "${FILESDIR}/upsd.rc6" upsd
	newinitd "${FILESDIR}/upsdrv.rc6" upsdrv
	newinitd "${FILESDIR}/upsmon.rc6" upsmon

	keepdir /var/lib/nut

	fperms 0700 /var/lib/nut
	fperms 0640 /etc/nut/{upsd.conf,upsd.users,upsmon.conf}
	fowners nut:nut /var/lib/nut
	fowners root:nut /etc/nut/{upsd.conf,upsd.users,upsmon.conf}
}

pkg_postinst() {
	# this is to ensure that everybody that installed old versions still has correct
	# permissions
	chown nut:nut ${ROOT}/var/lib/nut 2>/dev/null
	chmod 0700 ${ROOT}/var/lib/nut 2>/dev/null
	chown root:nut ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf} 2>/dev/null
	chmod 0640 ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf} 2>/dev/null
}
