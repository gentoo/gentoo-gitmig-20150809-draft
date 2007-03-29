# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin-fuzzyocr/spamassassin-fuzzyocr-2.3b.ebuild,v 1.6 2007/03/29 23:29:39 ticho Exp $

inherit perl-module

MY_P="fuzzyocr-${PV}"
DESCRIPTION="SpamAssassin plugin for performing Optical Character Recognition (OCR) on attached images"
HOMEPAGE="http://fuzzyocr.own-hero.net/"
SRC_URI="http://users.own-hero.net/~decoder/fuzzyocr/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""
DEPEND="dev-lang/perl
	>=mail-filter/spamassassin-3.0.0"
RDEPEND="${DEPEND}
	media-libs/netpbm
	media-gfx/imagemagick
	media-libs/giflib
	app-text/gocr
	dev-perl/String-Approx
	virtual/perl-Digest-MD5"

S="${WORKDIR}/FuzzyOcr-${PV}"

src_install() {
	# called to get ${VENDOR_LIB}
	perlinfo

	local plugin_dir=${VENDOR_LIB}/Mail/SpamAssassin/Plugin

	insinto ${plugin_dir}
	doins FuzzyOcr.pm

	insinto /etc/mail/spamassassin/

	# Replace location of .pm file in config
	sed -ie "s:FuzzyOcr.pm:${plugin_dir}/FuzzyOcr.pm:" FuzzyOcr.cf

	# disable logging
	sed -ie "s:^#focr_verbose 1:focr_verbose 0.0:" FuzzyOcr.cf

	# if we're using spamassassin < 3.1.4 we need to set this variable
	if has_version '<mail-filter/spamassassin-3.1.4'; then
		sed -ie "s:^#focr_pre314 0.0:focr_pre314 1:" FuzzyOcr.cf
	fi

	doins FuzzyOcr.cf

	newins FuzzyOcr.words.sample FuzzyOcr.words

	dodoc FAQ
	docinto samples
	dodoc samples/*
}


pkg_postinst() {
	elog "You need to restart spamassassin (as root) before this plugin will work:"
	elog "/etc/init.d/spamd restart"
	echo
	ewarn "Certain images can cause giftext and gocr to segfault, patches are available"
	ewarn "for both packages in bugzilla and should eventually find their way either"
	ewarn "upstream or into the ebuilds. The patches can be found here:"
	ewarn "gocr: https://bugs.gentoo.org/157138"
	ewarn "giftext: https://bugs.gentoo.org/157142"
}
