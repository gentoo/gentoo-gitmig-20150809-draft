# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nut/nut-1.4.0-r3.ebuild,v 1.3 2004/01/30 07:11:04 drobbins Exp $

DESCRIPTION="Network-UPS Tools."
SRC_URI="http://www.exploits.org/nut/release/${PV%.*}/${P}.tar.gz"
HOMEPAGE="http://www.exploits.org/nut/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="cgi"

RDEPEND="cgi? ( =media-libs/libgd-1* )"
DEPEND="$RDEPEND
	>=sys-apps/sed-4
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A} && cd "${S}"

	sed -e "s:GD_LIBS.*=.*-L/usr/X11R6/lib \(.*\) -lXpm -lX11:GD_LIBS=\"\1:" \
		-i configure.in || die "sed failed"

	ebegin "Recreating configure"
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"
	eend $?
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with cgi` `use_with cgi cgipath /usr/share/nut`"

	econf \
		--with-user=nut \
		--with-group=nut \
		--with-drvpath=/lib/nut \
		--sysconfdir=/etc/nut \
		--with-logfacility=LOG_DAEMON \
		--with-statepath=/var/lib/nut \
		--with-linux-hiddev \
		${myconf}

	sed -e "s:= bestups:= hidups bestups:" \
		-i drivers/Makefile || die "sed failed"
	sed -e "s:= powercom.8:= hidups.8 powercom.8:" \
		-i man/Makefile || "sed failed"

	emake || die "compile problem"

	if [ "`use cgi`" ] ; then
		emake cgi || die "compile cgi problem"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodir /sbin
	dosym /lib/nut/upsdrvctl /sbin/upsdrvctl

	for i in "${D}"/etc/nut/*.sample ; do
		mv "${i}" "${i/.sample/}"
	done

	if [ "`use cgi`" ] ; then
		make DESTDIR="${D}" install-cgi || die "make install-cgi failed"
		einfo "CGI monitoring scripts are installed in /usr/share/nut,"
		einfo "copy them to your web server's ScriptPath to activate."
	fi

	dodoc CHANGES COPYING CREDITS INSTALL MAINTAINERS NEWS README UPGRADING \
		docs/{FAQ,*.txt,driver.list}

	docinto cables
	dodoc docs/cables/*

	exeinto /etc/init.d
	newexe "${FILESDIR}/upsd.rc6" upsd
	newexe "${FILESDIR}/upsdrv.rc6" upsdrv
	newexe "${FILESDIR}/upsmon.rc6" upsmon

	keepdir /var/lib/nut
}

pkg_postinst() {
	chown nut:nut ${ROOT}/var/lib/nut
	chmod 0700 ${ROOT}/var/lib/nut
	chown root:nut ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf}
	chmod 0640 ${ROOT}/etc/nut/{upsd.conf,upsd.users,upsmon.conf}
}
