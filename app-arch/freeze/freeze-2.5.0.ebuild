DESCRIPTION="freeze / melt compression program"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/utils/compress/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# hard links confuse prepman and these links are absolute
	sed -i.orig \
		-e "s:ln -f \$@ \$(DEST):ln -sf freeze \$(DEST):g" \
		-e "s:ln -f \$@ \$(MANDEST):ln -sf freeze.\$(SEC) \$(MANDEST):g" \
		Makefile.in
}

src_compile() {
	cd ${S}

	econf || die "configure failed"
	emake	CC="gcc" \
		CFLAGS="$CFLAGS" \
		OPTIONS="-DDEFFILE=\\\"/etc/freeze.cnf\\\"" \
		|| die "compile failed"
}

src_install() {
	cd ${S}

	dodir /usr/bin /usr/share/man/man1
	make	DEST="$D/usr/bin" \
		MANDEST="$D/usr/share/man/man1" \
		install

	dobin showhuf
	dodoc README *.lsm
}
