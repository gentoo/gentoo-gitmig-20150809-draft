# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/signing-party/signing-party-0.4.6.ebuild,v 1.1 2006/05/27 13:47:33 jokey Exp $

DESCRIPTION="A collection of several tools related to OpenPGP"
HOMEPAGE="http://pgp-tools.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/s/signing-party/signing-party_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv recode"

DEPEND=""
RDEPEND=">=app-crypt/gnupg-1.3.92
	dev-perl/GnuPG-Interface
	dev-perl/text-template
	dev-perl/MIME-tools
	>=dev-perl/MailTools-1.62
	virtual/mailx
	virtual/mta
	!app-crypt/keylookup
	dev-lang/perl
	iconv? ( dev-perl/Text-Iconv )
	recode? ( app-text/recode )"

src_unpack() {
	unpack ${A}
	sed -i -e "s:/usr/share/doc/signing-party/caff/caffrc.sample:/usr/share/doc/${P}/caff/caffrc.sample.gz:g" ${S}/caff/caff
}

src_install() {
	# This is taken from debian/install
	# Check debian/install for instructions when a new tool is introduced to
	# this package
	dobin caff/caff caff/pgp-clean caff/pgp-fixkey
	dobin gpglist/gpglist
	dobin gpgsigs/gpgsigs
	dobin gpg-key2ps/gpg-key2ps
	dobin gpg-mailkeys/gpg-mailkeys
	dobin keylookup/keylookup
	doman */*.1
	dodoc README TODO
	docinto caff
	dodoc caff/README* caff/THANKS caff/TODO caff/caffrc.sample
	docinto gpg-key2ps
	dodoc gpg-key2ps/README
	docinto gpg-mailkeys
	dodoc gpg-mailkeys/README gpg-mailkeys/example.gpg-mailkeysrc
	docinto keylookup
	dodoc keylookup/NEWS
}
