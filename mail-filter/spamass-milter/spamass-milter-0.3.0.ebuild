# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamass-milter/spamass-milter-0.3.0.ebuild,v 1.1 2005/02/09 18:34:33 gustavoz Exp $

IUSE=""

DESCRIPTION="A Sendmail milter for SpamAssassin"
HOMEPAGE="http://savannah.nongnu.org/projects/spamass-milt/"
SRC_URI="http://savannah.nongnu.org/download/spamass-milt/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

DEPEND=">=sys-devel/autoconf-2.57
	>=sys-devel/automake-1.7.2"
RDEPEND=">=mail-mta/sendmail-8.12.9
	>=mail-filter/spamassassin-2.53"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README ChangeLog ${FILESDIR}/README.gentoo

	exeinto /etc/init.d ; newexe ${FILESDIR}/spamass-milter.rc spamass-milter
	insinto /etc/conf.d ; newins ${FILESDIR}/spamass-milter.conf spamass-milter
}

pkg_postinst() {
	einfo ""
	einfo "Documentation is in /usr/share/doc/${P}"
	einfo "Check README.gentoo.gz there for some basic gentoo installation instructions"
	einfo ""
}
