# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/bastille/bastille-2.1.1.ebuild,v 1.6 2003/08/27 00:05:35 seemant Exp $

inherit perl-module

IUSE="tcltk"

MY_PN=${PN/b/B}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Bastille-Linux is a security hardening tool"
HOMEPAGE="http://bastille-linux.org/"
SRC_URI="mirror://sourceforge/${PN}-linux/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-0.1.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"


RDEPEND="net-firewall/iptables
	app-admin/logrotate
	dev-perl/Curses
	tcltk? ( dev-perl/perl-tk )"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-gentoo-0.1.patch
}

src_compile() {

	cd ${S}/psad/Psad.pm
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/psad/Unix-Syslog-0.98
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/psad/whois-4.5.29
	emake || die
	
	cd ${S}
}

src_install() {
	
	keepdir /var/log/psad /var/lib/psad /var/run/psad /var/lock/subsys/${PN}
	dodir /etc/Bastille

	cd ${S}/psad/Psad.pm
	perl-module_src_install

	cd ${S}/psad/Unix-Syslog-0.98
	perl-module_src_install

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
	use tcltk && doins Bastille_Tk.pm
	insinto ${SITE_LIB}/Curses
	doins Curses/Widgets.pm

	doman docs/bastille.1m
	dodoc docs/* firewall/*.txt

	cd ${S}/psad
	insinto /usr/share/Bastille
	doins psad psadwatchd kmsgsd diskmond psad-init
	doman psad.8

	insinto /etc/psad
	doins psad_signatures psad_auto_ips psad.conf

	cd ${S}/psad/whois-4.5.29
	exeinto /usr/share/Bastille
	doexe whois

	cd ${S}/Bastille

	insinto /usr/lib/Bastille
	doins AccountSecurity.pm Apache.pm API.pm OSX_API.pm BootSecurity.pm \
		ConfigureMiscPAM.pm DisableUserTools.pm DNS.pm \
		FilePermissions.pm FTP.pm Firewall.pm HP_API.pm HP_UX.pm \
		IOLoader.pm Patches.pm Logging.pm \
		MiscellaneousDaemons.pm PatchDownload.pm Printing.pm PSAD.pm \
		RemoteAccess.pm SecureInetd.pm Sendmail.pm TMPDIR.pm  \
		test_AccountSecurity.pm test_Apache.pm test_DNS.pm \
		test_FTP.pm test_HP_UX.pm test_MiscellaneousDaemons.pm \
		test_SecureInetd.pm test_Sendmail.pm TestAPI.pm IPFilter.pm 

	# Documentation
	cd ${S}
	dodoc *.txt COPYING BUGS Change* README*
}

pkg_postinst() {
	if [ -z ${ROOT}/var/log/psadfifo ]
	then
		ebegin "Creating FIFO device for PSAD..."
		mknod -m 600 ${ROOT}/var/log/psadfifo p
		eend $?
	fi
	use tcltk || einfo "When not using the Tk interface you will need to start use the -c flag when calling ${PN} from command line. example ${PN} -c --os GE1.4"
}
