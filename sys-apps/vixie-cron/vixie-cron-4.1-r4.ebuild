# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vixie-cron/vixie-cron-4.1-r4.ebuild,v 1.7 2004/12/09 13:16:53 gmsoft Exp $

inherit eutils flag-o-matic toolchain-funcs debug

# no useful homepage, bug #65898
HOMEPAGE="ftp://ftp.isc.org/isc/cron/"
DESCRIPTION="Paul Vixie's cron daemon, a fully featured crond implementation"

SELINUX_PATCH="${P}-selinux.diff"
GENTOO_PATCH_REV="r3"

SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${GENTOO_PATCH_REV}.patch.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc sparc ~alpha ~mips hppa ~ia64 ~amd64 ~ppc64"
IUSE="selinux pam debug"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	selinux? ( sys-libs/libselinux )
	pam? ( sys-libs/pam )"

RDEPEND="!virtual/cron
	>=sys-apps/cronbase-0.2.1-r3
	 virtual/mta
	 selinux? ( sys-libs/libselinux )
	 pam? ( sys-libs/pam )"

PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-gentoo-${GENTOO_PATCH_REV}.patch
	epatch ${FILESDIR}/crontab.5.diff
	epatch ${FILESDIR}/${P}-commandline.patch

	use pam && epatch ${FILESDIR}/${P}-pam.patch
	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}
}

src_compile() {
	# we need to tinker with ldflags since we're installing as setuid. see
	# "[gentoo-core] Heads up changes in suid handing with portage >=51_pre21"
	# for details. Note that we do the sed fixes here rather than in unpack so
	# that our changes to LDFLAGS are picked up.

	append-ldflags -Wl,-z,now
	use debug && append-flags -DDEBUGGING

	sed -i -e "s:gcc \(-Wall.*\):$(tc-getCC) \1 ${CFLAGS}:" \
		-e "s:^\(LDFLAGS[ \t]\+=\).*:\1 ${LDFLAGS}:" Makefile \
		|| die "sed Makefile failed"

	emake || die "emake failed"
}

src_install() {
	# this does not work if the directory exists already
	diropts -m0750 -o root -g cron
	dodir /var/spool/cron/crontabs
	keepdir /var/spool/cron/crontabs/

	doman crontab.1 crontab.5 cron.8

	dodoc CHANGES CONVERSION FEATURES MAIL README THANKS

	diropts -m0755 ; dodir /etc/cron.d
	keepdir /etc/cron.d/

	exeinto /etc/init.d
	newexe ${FILESDIR}/vixie-cron.rc6 vixie-cron

	insinto /etc
	insopts -o root -g root -m 0644
	newins  ${FILESDIR}/crontab-3.0.1-r4 crontab
	newins ${FILESDIR}/${P}-cron.deny cron.deny

	dodoc ${FILESDIR}/crontab

	insinto /usr/sbin
	insopts -o root -g root -m 0750 ; doins cron

	insinto /usr/bin
	insopts -o root -g cron -m 4750 ; doins crontab

	if use pam ; then
		insinto /etc/pam.d
		insopts -o root -g root -m 0644
		newins ${FILESDIR}/cron.pam.d cron
	fi
}

pkg_postinst() {
	if [ -f ${ROOT}/etc/init.d/vcron ]
	then
		ewarn "Please run:"
		ewarn "rc-update del vcron"
		ewarn "rc-update add vixie-cron default"
	fi

	# bug 71326
	if [ -u ${ROOT}/etc/pam.d/cron ] ; then
		echo
		ewarn "Warning: previous ebuilds didn't reset permissions prior"
		ewarn "to installing crontab, resulting in /etc/pam.d/cron being"
		ewarn "installed with the SUID and executable bits set."
		ewarn
		ewarn "Run the following as root to set the proper permissions:"
		ewarn "   chmod 0644 /etc/pam.d/cron"
		echo
	fi
}
