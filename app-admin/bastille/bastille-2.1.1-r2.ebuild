# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bastille/bastille-2.1.1-r2.ebuild,v 1.9 2005/04/05 18:02:56 battousai Exp $

inherit perl-module eutils

PATCHVER=0.1
MY_PN=${PN/b/B}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Bastille-Linux is a security hardening tool"
HOMEPAGE="http://bastille-linux.org/"
SRC_URI="mirror://sourceforge/${PN}-linux/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~amd64"
IUSE="X"

RDEPEND="net-firewall/iptables
	app-admin/logrotate
	dev-perl/Curses
	net-firewall/psad
	X? ( dev-perl/perl-tk )"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-gentoo-${PATCHVER}.patch
	epatch ${FILESDIR}/bastille-firewall-imap.patch
	epatch ${FILESDIR}/${P}-hlist-fix.patch
}

src_compile() {
	cd ${S}
	cp ${FILESDIR}/bastille-${PV}-firewall.init ./bastille-firewall

	cd ${S}/psad/Psad.pm
	perl-module_src_compile
}

src_install() {

	keepdir /var/lock/subsys/${PN}
	dodir /etc/Bastille

	cd ${S}
	into /usr
	dosbin bastille AutomatedBastille InteractiveBastille \
		BastilleBackEnd RevertBastille *.pl

	dosym RevertBastille /usr/sbin/UndoBastille

	insinto /usr/share/Bastille
	doins Questions* Credits bastille-* *.xbm *.config

	insinto /usr/share/Bastille
	doins Questions.txt Credits complete.xbm incomplete.xbm \
		ifup-local hosts.allow

	exeinto /usr/share/Bastille
	doexe bastille-firewall* bastille-tmpdir* \
		bastille-ipchains bastille-netfilter \
		firewall/*.sh

	perlinfo
	insinto ${SITE_LIB}
	doins Bastille_Curses.pm
	use X && doins Bastille_Tk.pm
	insinto ${SITE_LIB}/Curses
	doins Curses/Widgets.pm

	doman docs/bastille.1m
	dodoc docs/* firewall/*.txt

	cd ${S}/Bastille

	insinto /usr/lib/Bastille
	doins AccountSecurity.pm Apache.pm API.pm OSX_API.pm BootSecurity.pm \
		ConfigureMiscPAM.pm DisableUserTools.pm DNS.pm \
		FilePermissions.pm FTP.pm Firewall.pm HP_API.pm HP_UX.pm \
		IOLoader.pm Patches.pm Logging.pm \
		MiscellaneousDaemons.pm PatchDownload.pm Printing.pm \
		RemoteAccess.pm SecureInetd.pm Sendmail.pm TMPDIR.pm  \
		test_AccountSecurity.pm test_Apache.pm test_DNS.pm \
		test_FTP.pm test_HP_UX.pm test_MiscellaneousDaemons.pm \
		test_SecureInetd.pm test_Sendmail.pm TestAPI.pm IPFilter.pm

	# psad interface module
	cd ${S}/psad/Psad.pm
	newins Psad.pm PSAD.pm

	# Documentation
	cd ${S}
	dodoc *.txt BUGS Change* README*
}

pkg_postinst() {
	use X || einfo "When not using the Tk interface you will need to start use the -c flag when calling ${PN} from command line. example ${PN} -c --os GE1.4"
}
