# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/posadis/posadis-0.60.1.ebuild,v 1.2 2003/12/07 23:48:10 foser Exp $

DESCRIPTION="An authoritive/caching Domain Name Server"
HOMEPAGE="http://www.posadis.org/projects/posadis.php"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fam"

DEPEND=">=dev-cpp/poslib-0.9.7
	fam? ( >=app-admin/fam-2.6.9 )"

src_compile() {
	econf `use_enable fam` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# make directory for posadis pidfile and zone data files
	keepdir /var/posadis
	keepdir /etc/posadis

	exeinto /etc/init.d; newexe ${FILESDIR}/${P}-init posadis
	insinto /etc/
	doins posadisrc

	dodoc AUTHORS ChangeLog INSTALL README TODO
}

pkg_preinst() {
	source /etc/init.d/functions.sh
	if [ -L ${svcdir}/started/posadis ]; then
		einfo "The posadis init script is running. I'll stop it, merge the new files and restart the script."
		/etc/init.d/posadis stop
	fi
}
