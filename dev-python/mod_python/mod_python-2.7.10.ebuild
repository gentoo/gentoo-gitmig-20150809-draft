# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mod_python/mod_python-2.7.10.ebuild,v 1.1 2004/01/24 21:06:45 liquidx Exp $

inherit python

DESCRIPTION="Python module for Apache 1.x, not for Apache 2.x"
SRC_URI="http://www.apache.org/dist/httpd/modpython/${P}.tgz"
HOMEPAGE="http://www.modpython.org/"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="=net-www/apache-1*"

src_unpack() {
	unpack ${A}
	# This patch from SuSE fixes the missing CFLAGS.
	# If you remove it, your apache will most likely
	# fail (lots of dieing pids in error_log).
	sed -e 's:OPT=:OPT=$(OPTFLAGS):' -i ${S}/src/Makefile.in
}

src_compile() {
	# If we dont add that, ./configure breaks this ebuild
	# because the last task (make depend) is somehow borked
	echo 'echo "configure done"' >> configure

	export OPTFLAGS="`/usr/sbin/apxs -q CFLAGS`"
	econf --with-apxs=/usr/sbin/apxs

	sed -e 's/LIBEXECDIR=\/usr\/lib\/apache/LIBEXECDIR=${D}\/usr\/lib\/apache-extramodules/' \
		-e 's/PY_STD_LIB=/PY_STD_LIB=${D}/' \
		-i Makefile

	sed -e 's/CFLAGS=$(OPT) $(INCLUDES)/CFLAGS=$(OPT) $(INCLUDES) -DEAPI -O0/' \
		-i ${S}/src/Makefile

	emake || die "emake failed"
}

src_install() {
	python_version
	PY_LIBPATH="/usr/lib/python${PYVER}"

	dodir /usr/lib/apache-extramodules
	dodir ${PY_LIBPATH}
	dodir /etc/apache/conf/addon-modules

	# compileall.py is needed or make install will fail
	cp ${PY_LIBPATH}/compileall.py ${D}${PY_LIBPATH}
	emake D=${D} install || die
	rm ${D}${PY_LIBPATH}/compileall.py

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_python.conf
	dodoc COPYRIGHT CREDITS NEWS README
	insinto /usr/share/doc/${PF}/html
	doins doc-html/*
	insinto /usr/share/doc/${PF}/html/icons
	doins doc-html/icons/*
}

pkg_postinst() {
	einfo
	einfo "To have Apache run python programs, please do the following:"
	einfo "1. Execute the command:"
	einfo " \"ebuild /var/db/pkg/dev-python/${PF}/${PF}.ebuild config\""
	einfo "2. Edit /etc/conf.d/apache and add \"-D PYTHON\""
	einfo
	einfo "That will include the ${PN} mime types in your configuration"
	einfo "automagically and setup Apache to load ${PN} when it starts."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_python.so mod_python.c python_module \
		before=perl define=PYTHON addconf=conf/addon-modules/mod_python.conf
	:;
}
