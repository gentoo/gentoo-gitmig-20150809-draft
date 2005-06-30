# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.2.ebuild,v 1.40 2005/06/30 03:58:28 kumba Exp $

inherit eutils flag-o-matic

DESCRIPTION="Network Time Protocol suite/programs"
HOMEPAGE="http://www.ntp.org/"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz
	mirror://gentoo/${PF}-manpages.tbz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"
IUSE="parse-clocks selinux ssl"

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	sys-libs/libcap
	ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )"
DEPEND="${RDEPEND}
	|| (
		dev-libs/libelf
		dev-libs/elfutils
	)
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.7
	>=sys-apps/sed-4.0.5"

hax_bitkeeper() {
	# the makefiles have support for bk ...
	# basically we have to do this or bk will try to write
	# to files in /opt/bitkeeper causing sandbox violations ;(
	mkdir ${T}/fakebin
	echo "#!/bin/sh"$'\n'"exit 1" > ${T}/fakebin/bk
	chmod a+x ${T}/fakebin/bk
	export PATH="${T}/fakebin:${PATH}"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	use alpha && epatch ${FILESDIR}/ntp-4.1.1b-syscall-libc.patch
	epatch ${FILESDIR}/broadcastclient.patch #17336
	epatch ${FILESDIR}/${PV}-droproot.patch #21444

	epatch ${FILESDIR}/linux-config-phone.patch #13001
	sed -i "s:-Wpointer-arith::" configure.in

	# needed in order to make files with right ver info #30220.
	aclocal -I . || die "autolocal"
	automake || die "automake"
	autoconf || die "autoconf"
}

src_compile() {
	hax_bitkeeper

	local mysslconf
	use ssl \
		&& mysslconf="--with-openssl-libdir=yes" \
		|| mysslconf="--with-openssl-libdir=no"
	econf \
		`use_enable parse-clocks` \
		${mysslconf} \
		|| die

	emake || die
}

pkg_preinst() {
	enewgroup ntp 123
	enewuser ntp 123 /bin/false /dev/null ntp
}

src_install() {
	hax_bitkeeper
	pkg_preinst

	make install DESTDIR=${D} || die

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	doman ${WORKDIR}/man/*.1
	dohtml -r html/*

	insinto /usr/share/ntp
	doins ${FILESDIR}/ntp.conf
	rm -rf `find scripts/ \
		-name '*.in' -o \
		-name 'Makefile*' -o \
		-name 'rc[12]' -o \
		-name support`
	mv scripts/* ${D}/usr/share/ntp/
	chmod -R go-w ${D}/usr/share/ntp

	[ ! -e ${ROOT}/etc/ntp.conf ] && insinto /etc && doins ${FILESDIR}/ntp.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/ntpd-${PV}.rc ntpd
	newexe ${FILESDIR}/ntp-client-${PV}.rc ntp-client
	insinto /etc/conf.d
	newins ${FILESDIR}/ntpd-${PV}.confd ntpd
	newins ${FILESDIR}/ntp-client.confd ntp-client

	dodir /var/lib/ntp
	fowners ntp:ntp /var/lib/ntp
	touch ${D}/var/lib/ntp/ntp.drift
	fowners ntp:ntp /var/lib/ntp/ntp.drift
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
}
