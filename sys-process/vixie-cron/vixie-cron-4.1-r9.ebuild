# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/vixie-cron/vixie-cron-4.1-r9.ebuild,v 1.12 2006/10/17 10:46:05 uberlord Exp $

inherit cron toolchain-funcs debug pam

# no useful homepage, bug #65898
HOMEPAGE="ftp://ftp.isc.org/isc/cron/"
DESCRIPTION="Paul Vixie's cron daemon, a fully featured crond implementation"

SELINUX_PATCH="${P}-selinux.diff"
GENTOO_PATCH_REV="r4"

SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${GENTOO_PATCH_REV}.patch.bz2"

LICENSE="as-is"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="selinux pam debug"

DEPEND=">=sys-apps/portage-2.0.47-r10
	selinux? ( sys-libs/libselinux )
	pam? ( virtual/pam )"

RDEPEND="selinux? ( sys-libs/libselinux )
	 pam? ( virtual/pam )"

pkg_setup() {
	enewgroup cron 16
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-gentoo-${GENTOO_PATCH_REV}.patch
	epatch ${FILESDIR}/crontab.5.diff
	epatch ${FILESDIR}/${P}-commandline.patch
	epatch ${FILESDIR}/${P}-basename.diff
	epatch ${FILESDIR}/${P}-setuid_check.patch

	use pam && epatch ${FILESDIR}/${P}-pam.patch
	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}
}

src_compile() {
	# we need to tinker with ldflags since we're installing as setuid. see
	# "[gentoo-core] Heads up changes in suid handing with portage >=51_pre21"
	# for details. Note that we do the sed fixes here rather than in unpack so
	# that our changes to LDFLAGS are picked up.

	append-ldflags $(bindnow-flags)
	use debug && append-flags -DDEBUGGING

	sed -i -e "s:gcc \(-Wall.*\):$(tc-getCC) \1 ${CFLAGS}:" \
		-e "s:^\(LDFLAGS[ \t]\+=\).*:\1 ${LDFLAGS}:" Makefile \
		|| die "sed Makefile failed"

	emake || die "emake failed"
}

src_install() {
	docrondir
	docron
	docrontab

	# /etc stuff
	insinto /etc
	newins  ${FILESDIR}/crontab-3.0.1-r4 crontab
	newins ${FILESDIR}/${P}-cron.deny cron.deny

	keepdir /etc/cron.d
	newpamd ${FILESDIR}/pamd.compatible cron
	newinitd ${FILESDIR}/vixie-cron.rc6 vixie-cron

	# doc stuff
	doman crontab.1 crontab.5 cron.8
	dodoc ${FILESDIR}/crontab
	dodoc CHANGES CONVERSION FEATURES MAIL README THANKS
}

pkg_postinst() {
	if [[ -f ${ROOT}/etc/init.d/vcron ]]
	then
		ewarn "Please run:"
		ewarn "rc-update del vcron"
		ewarn "rc-update add vixie-cron default"
	fi

	# bug 71326
	if [[ -u ${ROOT}/etc/pam.d/cron ]] ; then
		echo
		ewarn "Warning: previous ebuilds didn't reset permissions prior"
		ewarn "to installing crontab, resulting in /etc/pam.d/cron being"
		ewarn "installed with the SUID and executable bits set."
		ewarn
		ewarn "Run the following as root to set the proper permissions:"
		ewarn "   chmod 0644 /etc/pam.d/cron"
		echo
	fi

	cron_pkg_postinst
}
