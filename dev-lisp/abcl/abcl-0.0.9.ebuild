# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/abcl/abcl-0.0.9.ebuild,v 1.1 2006/01/11 23:51:00 mkennedy Exp $

inherit eutils java-pkg

DESCRIPTION="Armed Bear Common Lisp (ABCL) is an implementation of ANSI Common Lisp that runs in a Java virtual machine."
HOMEPAGE="http://armedbear.org/abcl.html"
SRC_URI="http://armedbear.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jad jikes clisp cmucl"

RDEPEND=">=virtual/jdk-1.4
	jad? ( dev-java/jad-bin )"

DEPEND=">=virtual/jdk-1.4
	!cmucl? ( !clisp? ( dev-lisp/sbcl ) )
	cmucl? ( dev-lisp/cmucl )
	clisp? ( dev-lisp/clisp )
	jikes? ( dev-java/jikes )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	local java_compiler="javac"
	use jikes && java_compiler="jikes"
	cat >${S}/customizations.lisp <<EOF
(in-package #:build-abcl)
(setf
*javac-options* "-g"
*jikes-options* "+D -g"
*jdk* "$(java-config --jdk-home)/"
*java-compiler* "$java_compiler"
*jar* "jar")
EOF
	einfo "Building with the following customizations.lisp:"
	cat ${S}/customizations.lisp
	cat >${S}/build.lisp <<'EOF'
(progn (load "build-abcl") (funcall (intern "BUILD-ABCL" "BUILD-ABCL") :clean t :full t) #+sbcl (sb-ext:quit) #+clisp (ext:quit) #+cmu (extensions:quit))
EOF
}

src_compile() {
	local lisp_compiler lisp_compiler_args
	if use clisp; then
		lisp_compiler="clisp"
		lisp_compiler_args="-ansi build.lisp"
	elif use cmucl; then
		lisp_compiler="lisp"
		lisp_compiler_args="-noinit -nositeinit -batch -load build.lisp"
	else
		lisp_compiler="sbcl"
		lisp_compiler_args="--sysinit /dev/null --userinit /dev/null --disable-debugger --load build.lisp"
	fi
	$lisp_compiler $lisp_compiler_args || die
}

src_install() {
	cat >abcl <<EOF
#!/bin/sh
exec \$(java-config --java) -Xmx256M -Xrs -Djava.library.path=/usr/$(get_libdir)/abcl/ -cp \$(java-config -p abcl) org.armedbear.lisp.Main "\$@"
EOF
	dobin abcl
	insinto /usr/$(get_libdir)/abcl
	doins src/org/armedbear/lisp/libabcl.so
	java-pkg_dojar abcl.jar
	dodoc README COPYING
}
