# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/libapreq2/libapreq2-2.06.ebuild,v 1.4 2005/08/14 21:20:49 ferdy Exp $

inherit perl-module

IUSE="doc"

MY_P=${P}-dev
S=${WORKDIR}/${MY_P}
DESCRIPTION="An Apache Request Perl Module"
SRC_URI="mirror://cpan/authors/id/J/JO/JOESUF/${MY_P}.tar.gz"
HOMEPAGE="http://httpd.apache.org/apreq/"
SLOT="2"
LICENSE="Apache-2.0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="${DEPEND}
	>=dev-perl/ExtUtils-XSBuilder-0.23
	>=net-www/apache-2.0.48
	doc? ( app-doc/doxygen )
	>=www-apache/mod_perl-2"

mydoc="TODO README CHANGES INSTALL"
myconf="--with-apache2-apxs=/usr/sbin/apxs2"
SRC_TEST="skip"

src_test() {
	if [ "${SRC_TEST}" == "do" ]; then
		if [ "`id -u`" == '0' ]; then
			chown nobody:nobody ${S}/module/t
			chown nobody:nobody ${T}
			GROUP="nobody" USER="nobody" \
				APACHE_TEST_NO_STICKY_PREFERENCES=1 \
				TMPDIR="${T}" HOME="${T}/" echo "" | emake test
		else
			APACHE_TEST_NO_STICKY_PREFERENCES=1 TMPDIR="${T}" HOME="${T}/" emake test
		fi
	fi
}

src_install() {
	emake -j1 DESTDIR=${D} LT_LDFLAGS="-L${D}/usr/lib" install || die
	make docs
	rm -f ${S}/docs/man/man3/_*
	for doc in `ls ${S}/docs/man/man3/*.3`; do
		doman $doc
	done
	# install the html docs
	dohtml ${S}/docs/html/*.html

	insinto /etc/apache2/modules.d
	doins ${FILESDIR}/76_mod_apreq.conf

	fixlocalpod

	for FILE in `find ${D} -type f |grep -v '.so'`; do
		STAT=`file $FILE| grep -i " text"`
		if [ "${STAT}x" != "x" ]; then
			sed -i -e "s:${D}:/:g" ${FILE}
		fi
	done

	for doc in Change* MANIFEST* README* ${mydoc}; do
		[ -s "$doc" ] && dodoc $doc
	done

}

pkg_postinst() {
	einfo
	einfo "To enable ${PN}, you need to edit your /etc/conf.d/apache2 file and"
	einfo "add '-D APREQ' to APACHE2_OPTS."
	einfo "Configuration file installed as"
	einfo "    /etc/apache2/modules.d/76_mod_apreq.conf"
	einfo "You may want to edit it before turning the module on in /etc/conf.d/apache2"
	einfo

}
