# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry/pinentry-0.6.7-r1.ebuild,v 1.4 2003/06/29 22:18:39 aliz Exp $

DESCRIPTION="This is a collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol as described by the aegypten project."
HOMEPAGE="http://www.gnupg.org/aegypten/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

IUSE="qt gtk ncurses"

DEPEND="gtk? ( x11-libs/gtk+ )
		ncurses? ( sys-libs/ncurses )
		qt? ( x11-libs/qt )"

pkg_setup() {
	use qt || use gtk || use ncurses || die "You must have at least one of 'qt', 'gtk', or 'ncurses' in your USE"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <<EOF
--- pinentry/qt/main.cpp	2002/11/05 19:44:34	1.7
+++ pinentry/qt/main.cpp	2003/01/21 12:25:59	1.8
@@ -157,6 +157,12 @@
 #ifdef FALLBACK_CURSES
   if( pinentry_have_display (argc, argv) ) {
 #endif
+	// Work around non-standard handling of DISPLAY
+	for( int i = 1; i < argc; ++i ) {
+    	if( !strcmp( "--display", argv[i] ) ) {
+        	argv[i] = "-display";
+    	}
+  	}
     return qt_main( argc, argv );
 #ifdef FALLBACK_CURSES
   } else {
--- pinentry/qt/pinentrycontroller.cpp	2002/09/30 09:27:10	1.9
+++ pinentry/qt/pinentrycontroller.cpp	2003/01/21 12:25:59	1.10
@@ -56,6 +56,8 @@
   
   assuan_set_malloc_hooks( secmem_malloc, secmem_realloc, secmem_free );
   int rc = assuan_init_pipe_server( &_ctx, fds );
+  assuan_set_log_stream (_ctx, stderr);
+
   if( rc ) {
     qDebug(assuan_strerror( static_cast<AssuanError>(rc) ));
     exit(-1);
EOF
}

src_compile() {
	econf	$(use_enable qt pinentry-qt) \
			$(use_enable gtk pinentry-gtk) \
			$(use_enable ncurses pinentry-curses) \
			$(use_enable ncurses fallback-curses) \
			--disable-dependency-tracking
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO

	# The other two pinentries don't spit out an insecure memory warning when
	# not suid root, and gtk refuses to start if pinentry-gtk is suid root.
	chmod +s "${D}"/usr/bin/pinentry-qt
}

pkg_postinst() {
	einfo "pinentry-qt is installed SUID root to make use of protected memory space"
	einfo "This is needed in order to have a secure place to store your passphrases,"
	einfo "etc. at runtime but may make some sysadmins nervous"
}
