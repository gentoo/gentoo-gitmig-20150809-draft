# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/spamass-milter/spamass-milter-0.2.0.ebuild,v 1.2 2003/09/05 09:07:00 msterret Exp $

IUSE=""

DESCRIPTION="A Sendmail milter for SpamAssassin"
HOMEPAGE="http://savannah.nongnu.org/projects/spamass-milt/"
SRC_URI="http://savannah.nongnu.org/download/spamass-milt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND=">=sys-devel/autoconf-2.57
	>=sys-devel/automake-1.7.2"
RDEPEND=">=net-mail/sendmail-8.12.9
	>=dev-perl/Mail-SpamAssassin-2.53"

S=${WORKDIR}/${P}

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
	einfo "less /usr/share/doc/spamass-milter-0.2.0/README.gentoo.gz"
	einfo "Very concise and simple install instructions. :)"
	einfo ""
}
