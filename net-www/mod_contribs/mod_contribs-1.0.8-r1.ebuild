# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_contribs/mod_contribs-1.0.8-r1.ebuild,v 1.11 2004/04/04 22:38:54 zul Exp $

# The mod_layout and mod_random that come in the archive are really old,
# so I've replaced them with more current versions.
mod_layout_ver=3.0.3
mod_random_ver=1.4

DESCRIPTION="Collection of third-party contributed modules for Apache"
HOMEPAGE="http://www.apache.org/dist/httpd/contrib/modules/1.3/"
S=${WORKDIR}/apache-contrib-${PV}
SRC_URI="mirror://apache//httpd/contrib/modules/1.3/apache-contrib-${PV}.tar.gz
	http://software.tangent.org/download/mod_layout-${mod_layout_ver}.tar.gz
	http://software.tangent.org/download/mod_random-${mod_random_ver}.tar.gz"

KEYWORDS="x86 sparc"
LICENSE="Apache-1.1"
SLOT="0"

DEPEND="virtual/glibc
	=net-www/apache-1*"

MY_MODS="mod_allowdev mod_auth_system mod_disallow_id mod_lock mod_random
	mod_auth_cookie mod_bandwidth mod_eaccess mod_macro mod_roaming
	mod_auth_cookie_file mod_cache mod_fastcgi mod_peephole mod_session
	mod_auth_external mod_cgisock mod_ip_forwarding mod_put mod_ticket
	mod_auth_inst mod_cvs mod_layout mod_qs2ssi mod_urlcount"

src_unpack() {
	unpack ${A} ; cd ${S}

	# update mod_random..
	cd ${S}/mod_random
	rm -f mod_random.c
	cp ${S}/../mod_random-${mod_random_ver}/{mod_random.c,README,faq.html} .

	# update mod_layout..
	cd ${S}/mod_layout
	rm -f mod_layout.c
	cp ${S}/../mod_layout-${mod_layout_ver}/{*.c,*.h,README,faq.html,directives/*} .
	cp Makefile Makefile.orig
	sed -e "s%^\(SRCS\)\(.*\)%\1\2 utility.c origin.c footer.c header.c%" \
		Makefile.orig > Makefile

	# fix to be like others: libcache.so -> mod_cache.so
	cd ${S}/mod_cache
	cp Makefile Makefile.orig
	sed -e "s%^\(DSO\).*%\1=mod_cache.so%" Makefile.orig > Makefile
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	local i
	for i in ${MY_MODS}
	do
		if [ -f $i/$i.so ]
		then
			exeinto /usr/lib/apache-extramodules
			doexe $i/$i.so
		fi
		if [ -f $i/README ]
		then
			docinto $i
			dodoc $i/README
		fi
		if [ -f $i/00BLURB ]
		then
			docinto $i
			dodoc $i/00BLURB
		fi
		ls $i/*.html >/dev/null 2>&1
		if [ $? -eq 0 ]
		then
			dodir /usr/share/doc/${PF}/${i}/html
			cp $i/*.html ${D}/usr/share/doc/${PF}/${i}/html
		fi
	done
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with these modules."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	local i j k
	for i in ${MY_MODS}
	do
		j="`echo $i | sed -e 's%mod_\(.*\)%\1%'`"
		k="`echo $j | tr a-z A-Z`"
		${ROOT}/usr/sbin/apacheaddmod \
			${ROOT}/etc/apache/conf/apache.conf \
			extramodules/$i.so $i.c ${j}_module define=$k
		if [ ! $? ]
		then
			ewarn "hrmph, problem auto-updating apache.conf for $i!"
		fi
	done
	:;
}
