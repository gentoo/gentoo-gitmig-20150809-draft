# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/piwi/piwi-0.0.20030717.ebuild,v 1.3 2004/03/21 13:03:35 mboman Exp $

DESCRIPTION="(Prelude|Perl) IDS Web Interface"
HOMEPAGE="http://www.prelude-ids.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres gd"
DEPEND="
	dev-lang/perl
	dev-perl/DBI
	dev-perl/Date-Calc
	postgresql? ( dev-perl/DBD-Pg )
	mysql? ( dev-perl/DBD-mysql )
	gd? ( dev-perl/GDGraph dev-perl/Geo-IP )
"
RDEPEND="${DEPEND}"

src_install() {
	into /home/httpd/htdocs/piwi || die
	into /etc/piwi || die

	# "install" the files into the destination
	cp -aR ${S}/* ${D}/home/httpd/htdocs/piwi/ || die

	# Fix permissions
	# Opt not to use the ebuild functions fowners() and fperms()
	# as they doesn't seem to work reqursively.
	chown -R root:apache ${D}/home/httpd/htdocs/piwi/* || die
	chown -R apache:apache ${D}/home/httpd/htdocs/piwi/generated || die
	chmod -R o-rwx ${D}/home/httpd/htdocs/piwi/* || die

	# Move files around and create symlinks to make sure configuration files
	# are not being overwritten when you do upgrades...
	mv ${D}/home/httpd/htdocs/piwi/generated/Filters ${D}/etc/piwi/Filters || die
	dosym /etc/piwi/Filters /home/httpd/htdocs/piwi/generated/Filters

	mv ${D}/home/httpd/htdocs/piwi/Profiles ${D}/etc/piwi/Profiles || die
	dosym /etc/piwi/Profiles /home/httpd/htdocs/piwi/Profiles

	mv ${D}/home/httpd/htdocs/piwi/Functions/config.pl ${D}/etc/piwi/config.pl || die
	dosym /etc/piwi/config.pl /home/httpd/htdocs/piwi/Functions/config.pl

	# Install configuration file for apache
	dodoc ${FILESDIR}/piwi-apache.conf
}

pkg_postinst() {
	einfo ""
	einfo "To have Apache run PIWI, please do the following:"
	einfo "1) Include the /usr/share/doc/${P}/piwi-apache.conf in your apache configuration"
	einfo "2) Edit /etc/conf.d/apache or /etc/conf.d/apache2 and add \"-D PIWI\""
	einfo "3) Edit /etc/piwi/config.pl to reflect your settings"
	ewarn ""
	ewarn "NOTE: If you do not perform these steps PIWI will _not_ work."
	ewarn "      You have been warned. Any bugs against this will be either:"
	ewarn ""
	ewarn "       - directed to /dev/null"
	ewarn "       - resolved with a RTFM comment"
	ewarn ""
	ewarn "Consider yourself warned"
	# Make sure that the user pay attention
	echo -ne "\a"; sleep 0.25 ; echo -ne "\a"; sleep 0.25
}
