typedef unsigned char uint8_t ;

const uint8_t video_mem = (char*)0xB8000;

int kernel_main(void) {

	video_mem[0] = 'X';
	video_mem[1] = 0x07;

	return 0;
}
