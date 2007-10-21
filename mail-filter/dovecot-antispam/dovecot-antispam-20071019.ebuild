# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dovecot-antispam/dovecot-antispam-20071019.ebuild,v 1.2 2007/10/21 16:31:07 hollow Exp $

inherit eutils autotools flag-o-matic multilib

DESCRIPTION="A dovecot antispam plugin supporting multiple backends"
HOMEPAGE="http://johannes.sipsolutions.net/Projects/dovecot-antispam"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dspam signature-log mailtrain crm114"

DEPEND="net-mail/dovecot
	dspam? ( mail-filter/dspam )
	crm114? ( app-text/crm114 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

# we need this to prevent errors from dovecot-config
top_builddir() {
	return
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's/$(INSTALLDIR)/$(DESTDIR)$(INSTALLDIR)/' -i Makefile
}

src_compile() {
	source "${ROOT}"/usr/lib/dovecot/dovecot-config || \
	die "cannot find dovecot-config"

	echo DOVECOT=${dovecot_incdir} > .config
	echo DOVECOT_VERSION=1.0 >> .config
	echo INSTALLDIR=${moduledir}/imap/ >> .config
	echo PLUGINNAME=antispam >> .config

	use dspam && echo BACKEND=dspam-exec >> .config
	use signature-log && echo BACKEND=signature-log >> .config
	use mailtrain && echo BACKEND=mailtrain >> .config
	use crm114 && echo BACKEND=crm114-exec >> .config

	use debug && echo DEBUG=stderr >> .config

	emake || die "make failed"
}

src_install () {
	source "${ROOT}"/usr/lib/dovecot/dovecot-config || \
	die "cannot find dovecot-config"

	dodir "${moduledir}"/imap/
	make DESTDIR="${D}" install || die "make install failed"

	newman antispam.7 dovecot-antispam.7
}
