# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/protobuf/protobuf-2.0.3.ebuild,v 1.1 2008/12/06 22:31:17 spock Exp $

inherit eutils distutils python java-pkg-opt-2

MY_P=${PN}-${PV//_/}

DESCRIPTION="Google's Protocol Buffers -- an efficient method of encoding structured data"
HOMEPAGE="http://code.google.com/p/protobuf/"
SRC_URI="http://protobuf.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples java python vim-syntax"

DEPEND="${DEPEND} java? ( >=virtual/jdk-1.5 )"
RDEPEND="${RDEPEND} java? ( >=virtual/jre-1.5 )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/protobuf-2.0.3-decoder_test_64bit_fix.patch"
}

src_compile() {
	econf || die
	emake || die

	if use python; then
		cd python; distutils_src_compile; cd ..
	fi

	if use java; then
		src/protoc --java_out=java/src/main/java --proto_path=src src/google/protobuf/descriptor.proto
		mkdir java/build
		cd java/src/main/java
		ejavac -d ../../../build $(find . -name '*.java') || die "java compilation failed"
		cd ../../../..
		jar cf ${PN}.jar -C java/build . || die "jar failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES.txt CONTRIBUTORS.txt README.txt

	if use python; then
		cd python; distutils_src_install; cd ..
	fi

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins editors/proto.vim
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "doins examples failed"
	fi

	if use java; then
		java-pkg_dojar ${PN}.jar
	fi
}

src_test() {
	emake check

	if use python; then
		 cd python; ${python} setup.py test || die "python test failed"
		 cd ..
	fi
}
