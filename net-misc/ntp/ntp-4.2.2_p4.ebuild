# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.2.2_p4.ebuild,v 1.3 2006/12/31 14:36:24 vapier Exp $

inherit eutils toolchain-funcs

MY_P=${P/_p/p}
DESCRIPTION="Network Time Protocol suite/programs"
HOMEPAGE="http://www.ntp.org/"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-${PV:0:3}/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-manpages.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ~ppc64 s390 sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="parse-clocks caps selinux ssl ipv6 debug openntpd"

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	kernel_linux? ( caps? ( sys-libs/libcap ) )
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

	# Needs to be ported ...
	#epatch "${FILESDIR}"/4.2.0.20040617-hostname.patch

	sed -i \
		-e 's:md5\.h:touch_not_my_md5:g' \
		-e 's:-lelf:-la_doe_a_deer_a_female_deer:g' \
		-e 's:-lmd5:-li_dont_want_no_stinkin_md5:g' \
		configure || die "sed failed"
}

src_compile() {
	hax_bitkeeper
	econf \
		$(use_enable caps linuxcaps) \
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
	doman "${WORKDIR}"/man/*.[58]
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
	use caps || dosed "s|-u ntp:ntp||" /etc/conf.d/ntpd
	dosed "s:-Q::" /etc/conf.d/ntp-client # no longer needed
	dosed "s:/usr/bin:/usr/sbin:" /etc/init.d/ntpd

	keepdir /var/lib/ntp
	fowners ntp:ntp /var/lib/ntp

	if use openntpd ; then
		cd "${D}"
		rm usr/sbin/ntpd || die
		rm -r var/lib
		rm etc/{conf,init}.d/ntpd
		rm usr/share/man/*/ntpd.8 || die
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
