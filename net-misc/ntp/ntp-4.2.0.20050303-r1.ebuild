# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.2.0.20050303-r1.ebuild,v 1.1 2005/08/25 22:10:40 vapier Exp $

inherit eutils

MY_P=${PN}-stable-${PV:0:5}a-${PV:6}
DESCRIPTION="Network Time Protocol suite/programs"
HOMEPAGE="http://www.ntp.org/"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/snapshots/ntp-stable/${PV:6:4}/${PV:10:2}/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-manpages.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="parse-clocks nodroproot selinux ssl ipv6 openntpd debug"

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	kernel_linux? ( !nodroproot? ( sys-libs/libcap ) )
	!openntpd? ( !net-misc/openntpd )
	ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"
PDEPEND="openntpd? ( net-misc/openntpd )"

S=${WORKDIR}/${MY_P}

hax_bitkeeper() {
	# the makefiles have support for bk ...
	# basically we have to do this or bk will try to write
	# to files in /opt/bitkeeper causing sandbox violations ;(
	mkdir "${T}"/fakebin
	echo "#!/bin/sh"$'\n'"exit 1" > "${T}"/fakebin/bk
	chmod a+x "${T}"/fakebin/bk
	export PATH="${T}/fakebin:${PATH}"
}

pkg_setup() {
	enewgroup ntp 123
	enewuser ntp 123 -1 /dev/null ntp
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/4.2.0-linux-config-phone.patch #13001
	epatch "${FILESDIR}"/4.2.0.20040617-hostname.patch
	epatch "${FILESDIR}"/4.2.0.20040617-errno-fix.patch
	epatch "${FILESDIR}"/4.2.0.20040617-debug-fix.patch
	epatch "${FILESDIR}"/4.2.0.20040617-freebsd.patch
	epatch "${FILESDIR}"/ntp-4.2.0-gcc4.patch
	epatch "${FILESDIR}"/ntp-4.2.0.20050303-rlimit-memlock.patch #99713
	epatch "${FILESDIR}"/ntp-4.2.0-ntpd-using-wrong-group.patch #103719

	sed -i \
		-e 's:md5\.h:touch_not_my_md5:g' \
		-e 's:-Wpointer-arith::' \
		-e 's:-lelf:-la_doe_a_deer_a_female_deer:g' \
		-e 's:-lmd5:-li_dont_want_no_stinkin_md5:g' \
		configure || die "sed failed"
}

src_compile() {
	hax_bitkeeper
	econf \
		$(use_enable !nodroproot linuxcaps) \
		$(use_enable parse-clocks) \
		$(use_enable ipv6) \
		$(use_enable debug debugging) \
		$(use_with ssl crypto) \
		|| die
	emake || die
}

src_install() {
	hax_bitkeeper
	make install DESTDIR="${D}" || die "install failed"
	# move ntpd/ntpdate to sbin #66671
	dodir /usr/sbin
	mv "${D}"/usr/bin/{ntpd,ntpdate} "${D}"/usr/sbin/ || die "move to sbin"

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	doman "${WORKDIR}"/man/*.1
	dohtml -r html/*

	insinto /usr/share/ntp
	doins "${FILESDIR}"/ntp.conf
	cp -r scripts/* "${D}"/usr/share/ntp/
	chmod -R go-w "${D}"/usr/share/ntp
	find "${D}"/usr/share/ntp \
		'(' \
		-name '*.in' -o \
		-name 'Makefile*' -o \
		-name 'rc[12]' -o \
		-name support \
		')' \
		-exec rm -r {} \;

	insinto /etc
	doins "${FILESDIR}"/ntp.conf
	newinitd "${FILESDIR}"/ntpd.rc ntpd
	newconfd "${FILESDIR}"/ntpd.confd ntpd
	newinitd "${FILESDIR}"/ntp-client.rc ntp-client
	newconfd "${FILESDIR}"/ntp-client.confd ntp-client
	use nodroproot && dosed "s|-u ntp:ntp||" /etc/conf.d/ntpd
	dosed "s:-Q::" /etc/conf.d/ntp-client # no longer needed
	dosed "s:/usr/bin:/usr/sbin:" /etc/init.d/ntpd

	dodir /var/lib/ntp
	fowners ntp:ntp /var/lib/ntp
	touch "${D}"/var/lib/ntp/ntp.drift
	fowners ntp:ntp /var/lib/ntp/ntp.drift

	if use openntpd ; then
		cd "${D}"
		rm usr/sbin/ntpd
		rm -r var/lib
		rm etc/{conf,init}.d/ntpd
	fi
}

pkg_preinst() {
	if [[ -e ${ROOT}/etc/ntp.conf ]] ; then
		rm -f "${D}"/etc/ntp.conf
	fi
}

pkg_postinst() {
	ewarn "You can find an example /etc/ntp.conf in /usr/share/ntp/"
	ewarn "Review /etc/ntp.conf to setup server info."
	ewarn "Review /etc/conf.d/ntpd to setup init.d info."
	echo
	einfo "The way ntp sets and maintains your system time has changed."
	einfo "Now you can use /etc/init.d/ntp-client to set your time at"
	einfo "boot while you can use /etc/init.d/ntpd to maintain your time"
	einfo "while your machine runs"
	if [[ -n $(egrep '^[^#].*notrust' "${ROOT}"/etc/ntp.conf) ]] ; then
		echo
		eerror "The notrust option was found in your /etc/ntp.conf!"
		ewarn "If your ntpd starts sending out weird responses,"
		ewarn "then make sure you have keys properly setup and see"
		ewarn "http://bugs.gentoo.org/41827"
	fi
}
