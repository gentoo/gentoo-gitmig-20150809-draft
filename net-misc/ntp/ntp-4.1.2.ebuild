# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.2.ebuild,v 1.26 2004/02/14 05:38:02 vapier Exp $

inherit eutils

DESCRIPTION="Network Time Protocol suite/programs"
HOMEPAGE="http://www.ntp.org/"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz
	mirror://gentoo/${PF}-manpages.tbz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~sparc mips alpha ~arm hppa ~amd64"
IUSE="parse-clocks selinux ssl"

RDEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	sys-libs/libcap
	ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )
	|| (
		dev-libs/libelf
		dev-libs/elfutils
	)"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.7.7
	>=sys-apps/sed-4.0.5"

pkg_setup() {
	enewgroup ntp 123
	enewuser ntp 123 /bin/false /dev/null ntp
}

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

	has_version "sys-devel/hardened-gcc" && append-flags "-yet_exec"

	local mysslconf
	use ssl \
		&& mysslconf="--with-openssl-libdir=yes" \
		|| mysslconf="--with-openssl-libdir=no"
	econf \
		--build=${CHOST} \
		`use_enable parse-clocks` \
		${mysslconf} \
		|| die

	has_version "sys-devel/hardened-gcc" && find ${WORKDIR} -name "Makefile" -type f -exec sed -i "s,-yet_exec,," {} \;

	emake || die
}

src_install() {
	hax_bitkeeper

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

	[ ! -e /etc/ntp.conf ] && insinto /etc && doins ${FILESDIR}/ntp.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/ntpd.rc ntpd
	newexe ${FILESDIR}/ntp-client.rc ntp-client
	insinto /etc/conf.d
	newins ${FILESDIR}/ntpd.confd ntpd
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
