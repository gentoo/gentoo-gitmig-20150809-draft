# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/disspam/disspam-0.12-r1.ebuild,v 1.2 2005/01/05 20:53:49 ticho Exp $

inherit eutils versionator

S=${WORKDIR}/${PN}
DESCRIPTION="A Perl script that removes spam from POP3 mailboxes based on RBLs."
HOMEPAGE="http://www.topfx.com/"
SRC_URI="http://www.topfx.com/dist/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~mips"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	>=dev-perl/libnet-1.11
	>=sys-apps/sed-4
	>=dev-perl/Net-DNS-0.12"

src_unpack() {
	unpack ${A}
	cd ${S}

	SA_VERSION=`echo \`best_version mail-filter/spamassassin\` | cut -d - -f 3`
	if version_is_at_least 3.0.2 ${SA_VERSION}; then
		epatch ${FILESDIR}/${PV}-sa302fix.patch || die "epatch failed"
	fi

	#This doesnt look neat but makes it work
	sed -i \
		-e 's/\/usr\/local\/bin\/perl/\/usr\/bin\/perl/' disspam.pl || \
			die "sed disspam.pl failed"
}

src_install() {
	dobin disspam.pl
	dodoc changes.txt configuration.txt readme.txt sample.conf
}
