# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/razor/razor-2.81.ebuild,v 1.4 2006/04/21 21:40:55 gustavoz Exp $

inherit perl-app

DESCRIPTION="Vipul's Razor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://razor.sourceforge.net/"
SRC_URI="mirror://sourceforge/razor/razor-agents-${PV}.tar.bz2"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

RDEPEND="dev-perl/Net-DNS
	virtual/perl-net-ping
	virtual/perl-Time-HiRes
	dev-perl/Digest-SHA1
	dev-perl/URI
	dev-perl/Digest-Nilsimsa"

S=${WORKDIR}/razor-agents-${PV}

pkg_postinst() {
	einfo ""
	einfo "Run 'razor-admin -create' to create a default config file in your"
	einfo "home directory under /home/user/.razor. (Remember to change user to"
	einfo "your username from root before running razor-admin)"
	einfo ""
	einfo "Razor v2 requires reporters to be registered so their reputations can"
	einfo "be computed over time and they can participate in the revocation"
	einfo "mechanism. Registration is done with razor-admin -register. It has to be"
	einfo "manually invoked in either of the following ways:"
	einfo ""
	einfo "To register user foo with 's1kr3t' as password: "
	einfo ""
	einfo "razor-admin -register -user=foo -pass=s1kr3t"
	einfo ""
	einfo "To register with an email address and have the password assigned:"
	einfo ""
	einfo "razor-admin -register -user=foo@bar.com      "
	einfo ""
	einfo "To have both (random) username and password assgined: "
	einfo ""
	einfo "razor-admin -register "
	einfo ""
	einfo "razor-admin -register negotiates a registration with the Nomination Server"
	einfo "and writes the identity information in"
	einfo "/home/user/.razor/identity-username, or /etc/razor/identity-username"
	einfo "when invoked as root."
	einfo ""
	einfo "You can edit razor-agent.conf to change the defaults. Config options"
	einfo "and their values are defined in the razor-agent.conf(5) manpage."
	einfo ""
	einfo "The next step is to integrate razor-check, razor-report and"
	einfo "razor-revoke in your mail system. If you are running Razor v1, the"
	einfo "change will be transparent, new versions of razor agents will overwrite"
	einfo "the old ones. You would still need to plugin razor-revoke in your MUA,"
	einfo "since it's a new addition in Razor v2. If you are not running Razor v1,"
	einfo "refer to manpages of razor-check(1), razor-report(1), and"
	einfo "razor-revoke(1) for integration instructions."
	einfo ""
}
