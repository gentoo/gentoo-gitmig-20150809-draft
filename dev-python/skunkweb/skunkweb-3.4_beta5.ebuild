# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/skunkweb/skunkweb-3.4_beta5.ebuild,v 1.2 2004/03/25 08:16:07 mr_bones_ Exp $


DESCRIPTION="robust Python web application server"
HOMEPAGE="http://skunkweb.sourceforge.net/"
NEWP=`echo ${P} | sed -e 's|_beta|b|'`
S=${WORKDIR}/${NEWP}
SRC_URI="mirror://sourceforge/skunkweb/${NEWP}.tar.gz"
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="${IUSE} apache1 apache2"
DEPEND=">=dev-lang/python-2.2
		>=dev-python/egenix-mx-base-2.0.4
		apache2? ( >=net-www/apache-2.0.47 )
		!apache2? ( apache1? ( <=net-www/apache-2 ) )"


pkg_setup() {
	if ! groupmod skunkweb; then
		groupadd skunkweb || die "problem adding group skunkweb"
	fi
	if ! id skunkweb; then
		useradd -g skunkweb -s /bin/false -d /usr/share/skunkweb -c "SkunkWeb user" skunkweb \
			|| die "problem adding user skunkweb"
	fi
}

pkg_postinst() {
	if [ -z "${INSTALLING}" ]; then
		einfo "NOTICE!"
		einfo "User and group 'skunkweb' have been added."
	fi
}

pkg_postrm() {
	if [ -z "${INSTALLING}" ] ; then
		einfo ">>> removing skunkweb user"
		userdel skunkweb || die "error removing skunk user"
		einfo ">>> removing skunkweb group"
		groupdel skunkweb || die "error removing skunkweb group"
	else
		einfo ">>> skunkweb user and group preserved"
	fi
}

src_compile() {
	local myconf
	if use apache2; then
		myconf="${myconf} --with-apxs=/usr/sbin/apxs2"
	else
		if use apache1; then
			myconf="${myconf} --with-apxs=/usr/sbin/apxs"
		else
			myconf="${myconf} --without-mod_skunkweb"
		fi
	fi
	./configure \
		--with-user=skunkweb \
		--with-group=skunkweb \
		--localstatedir=/var/lib/skunkweb \
		--bindir=/usr/bin \
		--libdir=/usr/lib/skunkweb \
		--sysconfdir=/etc/skunkweb \
		--prefix=/usr/share/skunkweb \
		--with-cache=/var/lib/skunkweb/cache \
		--with-docdir=/usr/share/doc/${P} \
		--with-logdir=/var/log/skunkweb \
		--with-python=/usr/bin/python \
		${myconf} || die "configure failed"

	emake || die
}

src_install() {
	INSTALLING="yes"
	make DESTDIR=${D} APXSFLAGS="-c" install || die
	if use apache2; then
		exeinto /usr/lib/apache2-extramodules
		doexe SkunkWeb/mod_skunkweb/.libs/mod_skunkweb.so
		insinto /etc/apache/conf/addon-modules
		newins SkunkWeb/mod_skunkweb/http_conf.stub mod_skunkweb.conf
	else
		if use apache1; then
			exeinto /usr/lib/apache-extramodules
			doexe SkunkWeb/mod_skunkweb/mod_skunkweb.so
			insinto /etc/apache/conf/addon-modules
			newins SkunkWeb/mod_skunkweb/http_conf.stub mod_skunkweb.conf
		fi
	fi
	dodoc README ChangeLog NEWS HACKING ACKS INSTALL
	if use doc; then
		cd ${S}/doc
		dodir /usr/share/doc/${PF}
		cp docs/paper-letter/*.pdf ${D}/usr/share/doc/${PF}
	fi
}
