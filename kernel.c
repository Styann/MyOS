int kernel_main(void) {
	volatile unsigned char *const video_mem = (unsigned char *)0xB8000;
	video_mem[0] = 'h';
	video_mem[1] = 'e';
	video_mem[2] = 'l';
	video_mem[3] = 'l';
	video_mem[4] = 'o';
	video_mem[5] = 0x07;

	return 0;
}
