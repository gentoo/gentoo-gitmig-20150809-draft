# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htp/htp-1.15.ebuild,v 1.5 2009/09/23 16:36:34 patrick Exp $

DESCRIPTION="An HTML preprocessor"
HOMEPAGE="http://htp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=""
RDEPEND=""

# HTP does not use autoconf, have to set options defined in Makefile.config

src_unpack() {
	unpack ${A} || die
	# Patch to remove meta-generator tag with "ego-gratifying Easter egg":
	patch -l "${S}/src/misc-proc.c" << EOF || die
		@@ -24,10 +23,0 @@
		-    /* authors ego-gratifying easter egg */
		-    /* put a generator meta-tag at the end of the HTML header */
		-    StreamPrintF(task->outfile,
		-                 "<meta name=\"Generator\" content=\"%s %s\"",
		-                 PROGRAM_NAME, VER_STRING);
		-    if(IsOptionEnabled(OPT_I_XML)) {
		-        StreamPrintF(task->outfile, " />\n");
		-    } else {
		-        StreamPrintF(task->outfile, ">\n");
		-    }
EOF
}

src_compile() {
	emake CCOPT="-c ${CFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" prefix="${D}/usr" pkgdocdir="${D}/usr/share/doc/${PF}" \
		install || die
}
